import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final bool isDisabled;
  final String? label; // String hoặc null đều được
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    required this.isDisabled,
    this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = NeutralColor.neutral_04; // Neutral 04
    Color fillColor = PrimaryColor.primary_00;
    Color overlayColor = Colors.transparent; // Màu phủ khi disabled

    if (isChecked) {
      fillColor = PrimaryColor.primary_05;
    }

    if (isDisabled) {
      overlayColor = NeutralColor.neutral_03; // Neutral 03
    }

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
        if (onChanged != null) {
          onChanged!(!isChecked);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor, width: 1.5),
                  color: fillColor,
                ),
                child: isChecked
                    ? const Icon(Icons.check, size: 18, color: Colors.white)
                    : null,
              ),
              if (isDisabled)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: overlayColor, // Phủ lớp mờ khi disabled
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
