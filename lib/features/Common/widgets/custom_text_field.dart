import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Function(String) onChanged;
  final String? initialValue;
  final bool isEnabled;
  final bool isSaving;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.initialValue,
    required this.onChanged,
    this.isEnabled = true,
    this.isSaving = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFB0B0B0),
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.8,
        ),
        enabled: isEnabled && !isSaving,
        border: _textFieldBorder(),
        enabledBorder: _textFieldBorder(),
        focusedBorder: _textFieldBorder(
          color: const Color(0xFF194595),
        ),
      ),
    );
  }

  InputBorder _textFieldBorder({
    Color color = const Color(0xFFF3F3F3),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
  }
}
