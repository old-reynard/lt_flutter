import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool hasError;
  final bool autoFocus;
  final bool autoCorrect;
  final String? hint;
  final String? initValue;
  final ValueChanged<String>? onChanged;
  final Widget? prefix;
  final int maxLines;

  PrimaryTextField({
    Key? key,
    this.controller,
    this.hasError = false,
    this.autoFocus = true,
    this.autoCorrect = true,
    this.hint,
    this.prefix,
    this.maxLines = 1,
    this.initValue,
    this.onChanged,
  }) : super(key: key);

  final inputDecorationColor = Colors.blue;

  final errorDecorationColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initValue,
      autocorrect: autoCorrect,
      autofocus: autoFocus,
      keyboardAppearance: Brightness.light,
      style: hasError ? Theme.of(context).inputDecorationTheme.errorStyle : Theme.of(context).textTheme.bodyText1,
      cursorColor: hasError ? Theme.of(context).errorColor : null,
      controller: controller,
      maxLines: maxLines,
      minLines: 1,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: hint,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: hasError ? errorDecorationColor : Theme.of(context).colorScheme.secondary),
        ),
        border: _border(context),
        enabledBorder: _border(context),
      ),
    );
  }

  InputBorder _border(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: hasError ? errorDecorationColor : Theme.of(context).textTheme.bodyText1!.color!),
    );
  }
}
