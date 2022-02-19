import 'package:little_things/map/models/pins.dart';
import 'package:little_things/meta/configuration.dart';
import 'package:little_things/meta/services/network_service.dart';

class MapService {
  final _api = Configuration.apiUrl;
  final _service = 'MapService';

  Future<List<PinCategory>> getCategories() async {
    final url = '$_api/categories';
    final bundle = NetworkBundle(url, method: 'getCategories', service: _service);
    final response = await request(bundle);
    return (response.body['categories'] as List).map<PinCategory>((e) => PinCategory.fromJson(e)).toList();
  }

  Future<List<Pin>> getPins() async {
    final url = '$_api/pins';
    final bundle = NetworkBundle(url, method: 'getPins', service: _service);
    final response = await request(bundle);
    return (response.body['pins'] as List? ?? []).map<Pin>((e) => Pin.fromJson(e)).toList();
  }
}
