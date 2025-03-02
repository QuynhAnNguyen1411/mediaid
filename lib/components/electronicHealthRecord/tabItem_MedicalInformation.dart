import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

enum TabState { defaultState, selectedState }

class TabItem extends StatelessWidget {
  final String title;
  final TabState state;
  final VoidCallback onTap;


  const TabItem({
    super.key,
    required this.title,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = state == TabState.selectedState;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 115,
        height: 61,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: (isSelected ? TextStyleCustom.heading_3b : TextStyleCustom.heading_3c)
                  .copyWith(color: isSelected ? PrimaryColor.primary_05 : NeutralColor.neutral_05),
            ),

            const SizedBox(height: 5),
            Container(
              width: 115,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected ? PrimaryColor.primary_05 : NeutralColor.neutral_03,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
