import 'package:flutter/material.dart';

typedef SecuredFieldValidator = String? Function(String? value);

class SecuredField extends StatefulWidget {
  final TextEditingController? controller;
  final SecuredFieldValidator? validator;
  final Widget? icon;
  final String? hintText;
  const SecuredField(
      {Key? key, this.controller, this.icon, this.hintText, this.validator})
      : super(key: key);

  @override
  State<SecuredField> createState() => _SecuredFieldState();
}

class _SecuredFieldState extends State<SecuredField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF3F3F3),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        prefixIcon: widget.icon,
        hintText: widget.hintText,
        helperText: "",
        suffixIcon: GestureDetector(
          onTap: () => setState(() => _obscureText = !_obscureText),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
