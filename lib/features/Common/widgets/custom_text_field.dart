import 'package:eram_express_shared/presentation/widgets/svgIcon.dart';
import 'package:flutter/material.dart';

//temp to use anaother way instead of statfulll
class CustomTextField extends StatefulWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final bool isEnabled;
  final bool isSaving;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.initialValue,
    required this.onChanged,
    this.isEnabled = true,
    this.isSaving = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: (value) {
        widget.onChanged!(value);
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFB0B0B0),
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.8,
        ),
        enabled: widget.isEnabled && !widget.isSaving,
        border: _textFieldBorder(),
        enabledBorder: _textFieldBorder(),
        focusedBorder: _textFieldBorder(
          color: const Color(0xFF194595),
        ),
        suffix: _controller.text.isNotEmpty
            ? const SvgIcon(
                asset: 'tick-circle',
              )
            : null,
      ),
      style: const TextStyle(
        color: Color(0xff191D31),
        fontFamily: 'Outfit',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.8,
      ),
    );
  }

  InputBorder _textFieldBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}
