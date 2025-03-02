
import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

enum ButtonType { standard, iconLeft, iconRight, iconOnly }
enum ButtonState { fill1, fill2, outline, text, disabled }

class CustomButton extends StatelessWidget {
   final String? text;
   final IconData? icon;
   final ButtonType type;
   final ButtonState state;
   final VoidCallback? onPressed;
   final double width;
   final double height;

  const CustomButton({super.key, this.text, this.icon, required this.type, required this.state, this.onPressed, required this.width, required this.height});
  Color _getTextColor() {
      if (state == ButtonState.disabled || onPressed == null) {
        return NeutralColor.neutral_06;
      }
      
      switch (state) {
        case ButtonState.fill1:
          return PrimaryColor.primary_00;
        case ButtonState.fill2:
        case ButtonState.outline:
        case ButtonState.text:
          return PrimaryColor.primary_05;
        case ButtonState.disabled:
          return NeutralColor.neutral_06;
      }
    }
  @override
  Widget build(BuildContext context) {
    bool isDisabled = state == ButtonState.disabled || onPressed == null;
    Color textColor = _getTextColor();
    Widget buttonChild = _buildButtonChild(textColor);

    if (isDisabled) {
      return _buildDisabledButton(_buildButtonChild(NeutralColor.neutral_06));
    }

    switch (state) {
      case ButtonState.fill1:
        return _buildFilledButton(PrimaryColor.primary_05, textColor, 0, buttonChild);
      case ButtonState.fill2:
        return _buildFilledButton(PrimaryColor.primary_00, textColor, 4, buttonChild);
      case ButtonState.outline:
        return _buildOutlinedButton(PrimaryColor.primary_05, textColor, buttonChild);
      case ButtonState.text:
        return _buildTextButton(textColor, buttonChild);
      case ButtonState.disabled:
        return _buildDisabledButton(_buildButtonChild(NeutralColor.neutral_06));
    }
  }

  Widget _buildDisabledButton(Widget child) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: PrimaryColor.primary_02,
        minimumSize: Size(width, height),
      ),
      child: child,
    );
  }
  Widget _buildButtonChild(Color textColor) {
    switch (type) {
      case ButtonType.iconLeft:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: textColor),
            const SizedBox(width: 8),
            Text(text ?? '', style: TextStyleCustom.button.copyWith(color: textColor)),
          ],
        );
      case ButtonType.iconRight:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text ?? '', style: TextStyleCustom.button.copyWith(color: textColor)),
            const SizedBox(width: 8),
            Icon(icon, size: 24, color: textColor),
          ],
        );
      case ButtonType.iconOnly:
        return Icon(icon, size: 24, color: textColor);
      case ButtonType.standard:
      return Text(text ?? '', style: TextStyleCustom.button.copyWith(color: textColor));
    }
  }

  Widget _buildFilledButton(Color backgroundColor, Color textColor, double elevation, Widget child) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: elevation,
        minimumSize: Size(width, height),
      ),
      child: child,
    );
  }

  Widget _buildOutlinedButton(Color borderColor, Color textColor, Widget child) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor),
        minimumSize: Size(width, height),
      ),
      child: child,
    );
  }

  Widget _buildTextButton(Color textColor, Widget child) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        minimumSize: Size(width, height),
      ),
      child: child,
    );
  }
}
