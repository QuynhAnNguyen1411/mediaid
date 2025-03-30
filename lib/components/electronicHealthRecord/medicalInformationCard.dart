import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

class MedicalInformationCard extends StatelessWidget{
  final String svgAssetPath;
  final String label;
  final VoidCallback onTap;
  const MedicalInformationCard({super.key, required this.label, required this.onTap, required this.svgAssetPath});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4.0,
        color: PrimaryColor.primary_00,
        child: Container(
          height: screenHeight * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: screenWidth * 0.15,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: PrimaryColor.primary_01,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        svgAssetPath,
                        width: screenWidth * 0.07,
                        height: screenHeight * 0.03,
                      ),
                    )
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyleCustom.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

