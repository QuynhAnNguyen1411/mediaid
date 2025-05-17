import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import 'package:mediaid/screens/logout/logout.dart';

import '../../api/electronicHealthRecordAPI/personalInformation_api.dart';
import '../../screens/electronicHealthRecord/electronicHealthRecord.dart';
import '../../screens/home/home.dart';
import '../../screens/setExaminationNumber/femaleBody.dart';
import '../../screens/setExaminationNumber/maleBody.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomNavBarState();
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  Future<int?> _loadGenderId() async {
    try {
      var box = await Hive.openBox('loginBox');
      var accountID = await box.get('accountID');
      var patient = await PersonalInformationApi.getPatientData(accountID);
      return patient?.sexPatient; // trả về genderId
    } catch (e) {
      print("Error loading gender ID: $e");
      return null;
    }
  }

  int currentIndexTab = 0;

  List<Widget> pages = [
    Home(),
    ElectronicHealthRecord(initialIndex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        body: FutureBuilder<int?>(
            future: _loadGenderId(), // Gọi hàm tải genderId
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                    CircularProgressIndicator()); // Hiển thị loading khi đang tải
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              }

              final genderId = snapshot.data;

              // Nếu không có genderId hoặc lỗi
              if (genderId == null) {
                return const Center(child: Text('No gender data found'));
              }

              List<Widget> pages = [
                Home(),
                ElectronicHealthRecord(initialIndex: 0),
                genderId == 1 ? MaleBody() : FemaleBody(),
                LogOut(),
              ];

              return Scaffold(
                backgroundColor: PrimaryColor.primary_00,
                body: pages[currentIndexTab],
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02),
                  child: GNav(
                    gap: screenWidth * 0.03,
                    activeColor: PrimaryColor.primary_05,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    tabBackgroundColor:
                    PrimaryColor.primary_01.withOpacity(0.5),
                    backgroundColor: PrimaryColor.primary_00,
                    color: NeutralColor.neutral_04,
                    textStyle: TextStyleCustom.bodyLarge
                        .copyWith(color: PrimaryColor.primary_05),
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: 'Trang chủ',
                      ),
                      GButton(
                        icon: Icons.assignment_ind_outlined,
                        text: 'Sổ khám',
                      ),
                      GButton(
                        icon: Icons.archive_outlined,
                        text: 'Đặt số',
                      ),
                      GButton(
                        icon: Icons.account_circle,
                        text: 'Tài khoản',
                      ),
                    ],
                    selectedIndex: currentIndexTab,
                    onTabChange: (index) {
                      setState(() {
                        currentIndexTab = index;
                        if (index == 1) {
                          pages[1] = ElectronicHealthRecord(initialIndex: 0);
                        }
                      });
                    }, // Gọi hàm thay đổi tab khi nhấn
                  ),
                ),
              );
            }));
  }
}
