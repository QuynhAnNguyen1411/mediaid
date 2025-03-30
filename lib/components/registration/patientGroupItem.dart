import 'package:flutter/cupertino.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class PatientGroupItem extends StatelessWidget {
  final bool isSelected;
  final bool isDisabled;
  final String label;
  final Widget icon;
  final ValueChanged<bool>? onChanged;


  const PatientGroupItem({
    super.key,
    required this.isSelected,
    required this.isDisabled,
    required this.label,
    required this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
        if (onChanged != null) {
          onChanged!(!isSelected);
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: screenWidth * 0.03, right: screenWidth * 0.03, top: screenHeight * 0.02, bottom: screenHeight * 0.02),
        decoration: BoxDecoration(
          color: isSelected
              ? PrimaryColor.primary_05
              : PrimaryColor.primary_00,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? PrimaryColor.primary_05
                : PrimaryColor.primary_03,
            width: isSelected ? screenWidth * 0.002 : screenWidth * 0.004,
          ),
        ),
        child: Column(
          children: [
            icon,
            SizedBox(height: screenHeight * 0.02),
            Text(
              label,
              style: (isSelected
                  ? TextStyleCustom.heading_3c
                  : TextStyleCustom.bodyLarge).copyWith(
                color: isSelected
                    ? PrimaryColor.primary_00
                    : PrimaryColor.primary_03,
              ),
            )
          ],
        ),
      ),
    );
  }
}