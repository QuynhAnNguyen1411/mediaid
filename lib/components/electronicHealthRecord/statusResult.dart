import 'package:flutter/material.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class StatusResult extends StatelessWidget{
  final String statusLabel;
  final Color statusColor;

  const StatusResult({super.key, required this.statusLabel, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.04,
      width: screenWidth * 0.3,
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          statusLabel,
          style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_00),
        ),
      ),
    );
  }

}