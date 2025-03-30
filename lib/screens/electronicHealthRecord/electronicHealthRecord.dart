import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/personalInformation.dart';
import '../../design_system/textstyle/textstyle.dart';
import 'medicalRecord/medicalRecord.dart';

class ElectronicHealthRecord extends StatefulWidget {
  const ElectronicHealthRecord({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ElectronicHealthRecord();
  }
}

class _ElectronicHealthRecord extends State<ElectronicHealthRecord>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quản lý sổ khám điện tử', style: TextStyleCustom.heading_2a.copyWith(color: PrimaryColor.primary_10),),
                  SvgPicture.asset(
                    'assets/icons/home/notification.svg',
                    width: screenWidth * 0.06,
                    height: screenHeight * 0.04,
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Thông tin cá nhân'),
                Tab(text: 'Lịch sử khám'),
              ],
              indicatorColor: PrimaryColor.primary_05,
              labelColor: PrimaryColor.primary_05,
              unselectedLabelColor: NeutralColor.neutral_04,
              indicatorWeight: 4.0,
              labelStyle: TextStyleCustom.heading_3b
                  .copyWith(color: PrimaryColor.primary_05),
              unselectedLabelStyle: TextStyleCustom.heading_3b
                  .copyWith(color: NeutralColor.neutral_04),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PersonalInformation(),
                  MedicalRecord(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
