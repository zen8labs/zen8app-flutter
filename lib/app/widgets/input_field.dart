import 'package:flutter/material.dart';
import 'package:zen8app/core/utils/common_types.dart';
import 'package:get/get.dart';

class VMInputField extends StatelessWidget {
  final TextEditingController controller;
  final ComponentBuilder<VMInputField>? leadingBuilder;
  final ComponentBuilder<VMInputField>? trailingBuilder;
  final Color backgroundColor;
  final String? hintText;
  final TextAlign textAlign;
  final double? height;
  final EdgeInsets insets;
  final bool isSecureTextEnabled;
  final bool isTextEditingEnabled;
  final double iconSize;

  final _isSecured = false.obs;
  VMInputField({
    Key? key,
    required this.controller,
    this.leadingBuilder,
    this.trailingBuilder,
    this.backgroundColor = const Color(0xffF5F5F5),
    this.hintText,
    this.textAlign = TextAlign.left,
    this.isSecureTextEnabled = false,
    this.isTextEditingEnabled = true,
    this.height = 56,
    this.iconSize = 24,
    this.insets = const EdgeInsets.only(left: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;
    if (leadingBuilder != null) {
      leadingWidget = leadingBuilder!(this);
    }

    Widget? trailingWidget;
    if (trailingBuilder != null) {
      trailingWidget = trailingBuilder!(this);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      height: height,
      child: Padding(
        padding: insets,
        child: Row(
          children: [
            if (leadingWidget != null)
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: leadingWidget,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(
                  () => TextField(
                    obscureText: _isSecured.value,
                    controller: controller,
                    textAlign: textAlign,
                    decoration: InputDecoration.collapsed(
                      hintText: hintText,
                    ),
                  ),
                ),
              ),
            ),
            if (isSecureTextEnabled)
              IconButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onPressed: () => {_isSecured.toggle()},
                icon: Obx(
                  () => Image.asset(
                    _isSecured.value
                        ? "resources/images/ic_eye_on.png"
                        : "resources/images/ic_eye_off.png",
                    width: iconSize,
                    height: iconSize,
                  ),
                ),
              ),
            if (trailingWidget != null)
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: trailingWidget,
              ),
          ],
        ),
      ),
    );
  }
}
