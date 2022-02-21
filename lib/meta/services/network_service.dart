// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:little_things/meta/models/json.dart';
import 'package:little_things/meta/services/globals.dart';
import 'package:logging/logging.dart';

const _allowedFormRequestVerbs = ['post', 'put'];
const _allowedHttpVerbs = ['post', 'put', 'get', 'delete'];


class UnauthorizedError implements Exception {
  final String message;

  UnauthorizedError([this.message = 'This call needs to be authorized']);
}

final _logger = Logger('Network');

class Reporter {
  static void logWarning(String serviceName, {String? message, String method = 'unknown'}) {
    _logger.warning('$serviceName: on attempt to $method: $message');
  }

  static void logInfo(String serviceName, {String? message, String method = 'unknown'}) {
    _logger.info('$serviceName: on attempt to $method: $message');
  }

  static void logSuccess(String serviceName, {String? message, String method = 'unknown'}) {
    _logger.info('$serviceName: on attempt to $method: $message');
  }

  static void log(String message) {
    _logger.info(message);
  }
}

extension on http.BaseResponse {
  bool get isPositive => statusCode >= 200 && statusCode < 300;

  bool get isUnauthorized => statusCode == 401;
}

extension on http.Response {
  bool get hasError => (jsonDecode(body) as Json).containsKey('error');

  String get error => (jsonDecode(body) as Json)['error'];
}

class Response {
  final int code;
  final Json body;
  final String? error;

  Response({
    required this.code,
    required this.body,
    this.error,
  });

  factory Response.empty(int code) {
    return Response(code: code, body: {});
  }

  factory Response.error(int code, String error) {
    return Response(code: code, body: {}, error: error);
  }

  @override
  String toString() {
    if (error != null) return '$code: $error';
    return '$code: $body';
  }
}

class _NetworkService {
  static Future<Response> makeRequest(NetworkBundle bundle, {bool allowErrors = false}) async {
    var headers = bundle.headers ?? requestHeaders;
    var url = Uri.parse(bundle.url);
    var body = jsonEncode(bundle.body);
    switch (bundle.verb) {
      case 'get':
        Reporter.log('GET on $url');
        var response = await http.get(url, headers: headers);
        if (response.isPositive) {
          Reporter.logSuccess(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
          return Response(code: response.statusCode, body: jsonDecode(response.body));
        } else {
          Reporter.logWarning(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
          if (allowErrors) {
            return Response(code: response.statusCode, body: jsonDecode(response.body));
          }

          if (response.isUnauthorized) {
            throw UnauthorizedError();
          }

          if (response.hasError) {
            return Response.error(response.statusCode, response.error);
          }
          return Response.empty(response.statusCode);
        }
      case 'put':
        Reporter.log('PUT with $body on $url');
        var response = await http.put(url, headers: headers, body: body);
        if (response.isPositive) {
          Reporter.logSuccess(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
          return Response(code: response.statusCode, body: jsonDecode(response.body));
        } else {
          Reporter.logWarning(bundle.service, method: bundle.method, message: 'response: ${response.statusCode}');

          if (allowErrors) {
            return Response(code: response.statusCode, body: jsonDecode(response.body));
          }

          if (response.hasError) {
            return Response.error(response.statusCode, response.error);
          }

          return Response.empty(response.statusCode);
        }
      case 'post':
        Reporter.log('POST with $body on $url');
        var response = await http.post(url, headers: headers, body: body);
        if (response.isPositive) {
          Reporter.logSuccess(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
          return Response(code: response.statusCode, body: jsonDecode(response.body));
        } else {
          Reporter.logWarning(bundle.service, message: 'response ${response.body}', method: bundle.method);

          if (allowErrors) {
            return Response(code: response.statusCode, body: jsonDecode(response.body));
          }

          if (response.hasError) {
            return Response.error(response.statusCode, response.error);
          }

          return Response.empty(response.statusCode);
        }
      case 'delete':
        final response = await http.delete(url, headers: headers);
        Reporter.log('DELETE on $url');
        if (response.isPositive) {
          Reporter.logSuccess(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
          try {
            return jsonDecode(response.body);
          } catch (_) {
            return Response.empty(response.statusCode);
          }
        } else {
          Reporter.logWarning(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
          return Response.empty(response.statusCode);
        }
      default:
        final message = 'Supported request verbs: ${_allowedHttpVerbs.join(", ")}';
        throw UnsupportedError(message);
    }
  }

  // ignore: unused_element
  static Future<Response> makeFormRequest(NetworkBundle bundle) async {
    final url = bundle.url;
    final body = bundle.body!;
    final verb = _allowedFormRequestVerbs.contains(bundle.verb) ? bundle.verb.toUpperCase() : 'POST';
    http.MultipartRequest request = http.MultipartRequest(verb, Uri.parse(url));
    final headers = bundle.headers;

    headers?.keys.forEach((key) => request.headers[key] = headers[key]!);
    body.keys.forEach((field) => request.fields[field] = body[field]);
    request.files.addAll(bundle.files!);

    Reporter.log('FORM ${request.method} with $body on $url');
    final response = await request.send();

    if (response.isPositive) {
      Reporter.logSuccess(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
      return Response(code: response.statusCode, body: jsonDecode(await response.stream.bytesToString()));
    } else {
      Reporter.logWarning(bundle.service, message: 'response ${response.statusCode}', method: bundle.method);
      if (response.isUnauthorized) {
        throw UnauthorizedError();
      }
      return Response.empty(response.statusCode);
    }
  }
}

Future<Response> request(NetworkBundle bundle, {bool allowErrors = false}) {
  return _NetworkService.makeRequest(bundle, allowErrors: allowErrors);
}

class NetworkBundle {
  final String url;
  final Map<String, dynamic>? body;
  final Map<String, String>? headers;
  final String verb;
  final String method;
  final String service;
  final bool protected;
  final List<http.MultipartFile>? files;

  NetworkBundle(
    this.url, {
    this.protected = true,
    this.verb = 'get',
    this.body,
    this.headers,
    this.method = 'unknownMethod',
    this.service = 'UnknownService',
    this.files,
  });
}
