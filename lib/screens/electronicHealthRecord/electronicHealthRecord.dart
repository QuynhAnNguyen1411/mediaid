import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/personalInformation.dart';
import '../../design_system/textstyle/textstyle.dart';
import '../../util/spacingStandards.dart';
import 'medicalRecord/generalRecordList.dart';

class ElectronicHealthRecord extends StatefulWidget {
  final int initialIndex;
  const ElectronicHealthRecord({super.key, this.initialIndex = 0});

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
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final iconSize = IconSizeUtil();
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SpacingUtil.spacingWidth16(context),
            vertical: SpacingUtil.spacingHeight24(context)),
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
                    width: iconSize.largeIcon(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
            SizedBox(height: SpacingUtil.spacingHeight16(context)),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PersonalInformation(),
                  GeneralRecordList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
