import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTextFieldWidget extends ConsumerWidget {
  const InputTextFieldWidget(
      {Key? key,
      required this.inputTextEditingController,
      required this.labelText,
      required this.validator,
      required this.obscureText})
      : super(key: key);

  final TextEditingController inputTextEditingController;
  final String labelText;
  final bool obscureText;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      obscureText: obscureText,
      controller: inputTextEditingController,
      decoration:
          InputDecoration(labelText: labelText, border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      validator: validator,
    );
  }
}
