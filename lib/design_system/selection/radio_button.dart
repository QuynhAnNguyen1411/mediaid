import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final bool isDisabled;
  final String? label;
  final ValueChanged<bool>? onChanged;

  const CustomRadioButton({
    super.key,
    required this.isSelected,
    required this.isDisabled,
    this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = NeutralColor.neutral_04;
    Color fillColor = Colors.transparent;
    Color overlayColor = Colors.transparent;

    if (isSelected) {
      fillColor = PrimaryColor.primary_05;
    }

    if (isDisabled) {
      overlayColor = NeutralColor.neutral_03;
    }

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
        if (onChanged != null) {
          onChanged!(!isSelected);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 1.5),
                  color: fillColor,
                ),
              ),
              if (isSelected)
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              if (isDisabled)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: overlayColor,
                  ),
                ),
            ],
          ),
          if (label != null) ...[
            const SizedBox(width: 8),
            Text(
              label!,
              style: TextStyleCustom.bodySmall,
            ),
          ]
        ],
      ),
    );
  }
}