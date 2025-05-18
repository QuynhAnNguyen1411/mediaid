import 'package:flutter/material.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/patientHistory/geneticDiseaseHistory.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/patientHistory/surgeryHistory.dart';
import '../../../../../design_system/color/neutral_color.dart';
import '../../../../../design_system/color/primary_color.dart';
import '../../../../../design_system/textstyle/textstyle.dart';
import '../../../../../util/spacingStandards.dart';
import 'allergyHistory.dart';
import 'medicalHistory.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  PatientHistoryState createState() => PatientHistoryState();
}

class PatientHistoryState extends State<PatientHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          title: Text(
            'Tiền sử y tế',
            style: TextStyleCustom.heading_2a
                .copyWith(color: PrimaryColor.primary_10),
          ),
          backgroundColor: PrimaryColor.primary_01,
          elevation: 4.0,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth16(context),
            vertical: SpacingUtil.spacingHeight24(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: false,
                  tabs: [
                    Tab(text: 'Bệnh tật'),
                    Tab(text: 'Bệnh di truyền'),
                    Tab(text: 'Dị ứng'),
                    Tab(text: 'Phẫu thuật'),
                  ],
                  indicatorColor: PrimaryColor.primary_05,
                  labelColor: PrimaryColor.primary_05,
                  unselectedLabelColor: NeutralColor.neutral_04,
                  indicatorWeight: 4.0,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelStyle: TextStyleCustom.heading_3b
                      .copyWith(color: PrimaryColor.primary_05),
                  unselectedLabelStyle: TextStyleCustom.heading_3b
                      .copyWith(color: NeutralColor.neutral_04),
                ),
                SizedBox(height: SpacingUtil.spacingHeight16(context)),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MedicalHistory(),
                      GeneticDiseaseHistory(),
                      AllergyHistory(),
                      SurgeryHistory(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
