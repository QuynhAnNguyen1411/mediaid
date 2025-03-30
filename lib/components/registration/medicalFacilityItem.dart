import 'package:flutter/material.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class MedicalFacilityItem extends StatelessWidget{
  final bool isSelected;
  final bool isDisabled;
  final String address;
  final ValueChanged<bool>? onChanged;


  const MedicalFacilityItem({
    super.key,
    required this.isSelected,
    required this.isDisabled,
    required this.address,
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
        padding: EdgeInsets.only(left: screenWidth * 0.02, right: screenWidth * 0.02, top: screenHeight * 0.01, bottom: screenHeight * 0.01),
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
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: isSelected
                  ? PrimaryColor.primary_00
                  : PrimaryColor.primary_03,
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Text(
                address,
                style: (isSelected
                    ? TextStyleCustom.heading_3c
                    : TextStyleCustom.bodyLarge).copyWith(
                  color: isSelected
                      ? PrimaryColor.primary_00
                      : PrimaryColor.primary_03,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

