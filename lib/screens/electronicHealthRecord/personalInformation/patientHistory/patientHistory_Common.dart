import 'package:flutter/material.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/surgeryHistory.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/neutral_color.dart';
import '../../../../design_system/color/primary_color.dart';
import '../../../../design_system/textstyle/textstyle.dart';
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
    _tabController = TabController(length: 3, vsync: this);
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo Hospital K
                  Image.asset(
                    'assets/logo/national_cancer_hospital_logo.jpg',
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.2,
                  ),

                  // Button display language
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.005),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFCCDEE7),
                          Color(0xFFCCDEE7),
                          Color(0xFF015C89),
                        ],
                        stops: [0.0, 0.12, 0.88],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // VN flag
                        Image.asset(
                          'assets/images/registration/vietnam_flag.jpg',
                          width: screenWidth * 0.08,
                          height: screenHeight * 0.04,
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Text Vietnam
                        Text(
                          'Vietnam',
                          style: TextStyleCustom.heading_3b
                              .copyWith(color: PrimaryColor.primary_00),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tiền sử y tế',
                  style: TextStyleCustom.heading_2a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: screenHeight * 0.02),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Bệnh tật'),
                    Tab(text: 'Dị ứng'),
                    Tab(text: 'Phẫu thuật'),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MedicalHistory(),
                      AllergyHistory(),
                      SurgeryHistory(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.fill2,
                      text: 'Quay lại',
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      onPressed: () {
                        if (_tabController.index == 0) {
                          Navigator.pushNamed(context, MediaidRoutes.electronicHealthRecord);
                        } else {
                          _tabController.animateTo(_tabController.index - 1);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.fill1,
                      text: 'Tiếp tục',
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      onPressed: () {
                        if (_tabController.index < _tabController.length - 1) {
                          _tabController.animateTo(_tabController.index + 1);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: PrimaryColor.primary_00,
                                elevation: 4.0,
                                title: Text("Hoàn thành"),
                                content: Text("Bạn đã hoàn thành việc điền thông tin tiểu sử y tế."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(context, MediaidRoutes.electronicHealthRecord);
                                    },
                                    child: Text("Đóng"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
