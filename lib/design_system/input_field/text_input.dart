import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

enum TextFieldType { text, textHelper, textIconRight, textIconRightHelper }
enum TextFieldState { defaultState, error, success, entered, disabled }

class CustomTextInput extends StatelessWidget {
  final String? label;
  final bool isRequired; // Thêm biến này để quyết định có dấu * hay không
  final String? helperText;
  final String? hintText;
  final IconData? icon;
  final TextFieldType type;
  final TextFieldState state;
  final TextEditingController? controller;
  final String? errorMessage;
  final VoidCallback? onTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextInput({
    super.key,
    this.label,
    this.isRequired = false, // Mặc định là không có dấu *
    this.helperText,
    this.hintText,
    this.icon,
    required this.type,
    required this.state,
    this.controller,
    this.errorMessage,
    this.onTap,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    bool isDisabled = state == TextFieldState.disabled;
    Color borderColor = _getBorderColor();
    Color textColor = isDisabled ? NeutralColor.neutral_04 : NeutralColor.neutral_10;
    Color helperColor = _getHelperColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) _buildLabel(),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          enabled: !isDisabled,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyleCustom.bodySmall.copyWith(
              color: NeutralColor.neutral_06,
            ),
            suffixIcon: _buildSuffixIcon(),
            border: OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: 2), borderRadius: BorderRadius.circular(12.0)),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
            errorText: state == TextFieldState.error ? errorMessage : null,
            filled: true,
            fillColor: isDisabled ? NeutralColor.neutral_01 : Colors.transparent,
          ),
          style: TextStyleCustom.bodySmall.copyWith(color: textColor),
        ),
        if (type == TextFieldType.textHelper || type == TextFieldType.textIconRightHelper)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              helperText ?? '',
              style: TextStyleCustom.bodySmall.copyWith(color: helperColor),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label!,
            style: TextStyleCustom.heading_3b.copyWith(color: PrimaryColor.primary_10),
          ),
          if (isRequired)
            TextSpan(
              text: ' *',
              style: TextStyle(color: StatusColor.errorFull),
            ),
        ],
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (type == TextFieldType.textIconRight || type == TextFieldType.textIconRightHelper) {
      return GestureDetector(
        onTap: onTap, // Khi ấn vào icon sẽ gọi onTap
        child: Icon(icon, size: 24, color: _getIconColor()),
      );
    }
    return null;
  }

  Color _getBorderColor() {
    switch (state) {
      case TextFieldState.error:
        return StatusColor.errorFull;
      case TextFieldState.success:
        return StatusColor.successFull;
      case TextFieldState.entered:
      case TextFieldState.defaultState:
        return NeutralColor.neutral_04;
      case TextFieldState.disabled:
        return NeutralColor.neutral_02;
    }
  }

  Color _getHelperColor() {
    switch (state) {
      case TextFieldState.error:
        return StatusColor.errorFull;
      case TextFieldState.success:
        return StatusColor.successFull;
      default:
        return NeutralColor.neutral_06;
    }
  }

  Color _getIconColor() {
    return state == TextFieldState.disabled ? NeutralColor.neutral_06 : NeutralColor.neutral_10;
  }
}
