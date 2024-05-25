import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction? action;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    this.action,
    this.hintStyle,
    this.textStyle,
    required this.hintText,
    required this.textInputType,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: textStyle,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),

          borderRadius: BorderRadius.circular(20), // Set border radius here
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),

          borderRadius: BorderRadius.circular(20), // Set border radius here
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(20), // Set border radius here
        ),
        filled: true,
        fillColor: const Color(0xffeceff6),
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
      onChanged: onChanged,
    );
  }
}
