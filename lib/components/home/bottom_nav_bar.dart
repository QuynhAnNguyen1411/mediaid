import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});


  Widget buildSvgIcon(String assetName, bool isSelected) {
    return
      SvgPicture.asset(
      assetName,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? PrimaryColor.primary_05 : NeutralColor.neutral_04,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PrimaryColor.primary_00,
      padding: EdgeInsets.all(8),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: PrimaryColor.primary_05,
        unselectedItemColor: NeutralColor.neutral_06,
        selectedLabelStyle: TextStyleCustom.bodySmall.copyWith(
            color: PrimaryColor.primary_05),
        unselectedLabelStyle: TextStyleCustom.bodySmall.copyWith(
            color: NeutralColor.neutral_06),
        elevation: 0,
        backgroundColor: PrimaryColor.primary_00,
        items: [
          BottomNavigationBarItem(
            icon: buildSvgIcon('assets/icons/bottom_nav_bar/home.svg', currentIndex == 0),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: buildSvgIcon('assets/icons/bottom_nav_bar/medical-records.svg', currentIndex == 1),
            label: 'Sổ khám',
          ),
          BottomNavigationBarItem(
            icon: buildSvgIcon('assets/icons/bottom_nav_bar/archive.svg', currentIndex == 2),
            label: 'Đặt số',
          ),
          BottomNavigationBarItem(
            icon: buildSvgIcon('assets/icons/bottom_nav_bar/chat.svg', currentIndex == 3),
            label: 'Liên hệ BS',
          ),
          BottomNavigationBarItem(
            icon: buildSvgIcon('assets/icons/bottom_nav_bar/user.svg', currentIndex == 4),
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }

}