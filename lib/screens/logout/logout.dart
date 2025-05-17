import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/screens/splash/splash.dart';

import '../../components/electronicHealthRecord/medicalInformationCard.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';
import '../../util/spacingStandards.dart';

class LogOut extends StatefulWidget {
  const LogOut({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogOutState();
  }
}

class _LogOutState extends State<LogOut> {

  Future<void> logout() async {
    var box = await Hive.openBox('loginBox');
    box.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));
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
          vertical: SpacingUtil.spacingHeight24(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quản lý tài khoản',
                    style: TextStyleCustom.heading_2a.copyWith(
                      color: PrimaryColor.primary_10,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/home/notification.svg',
                    width: iconSize.largeIcon(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: SpacingUtil.spacingHeight24(context)),
            // Log out Card
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      logout();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4.0,
                      color: PrimaryColor.primary_00,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SpacingUtil.spacingWidth12(context),
                          vertical: SpacingUtil.spacingHeight12(context),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Log out Icon
                              Container(
                                width: screenWidth * 0.15,
                                height: screenHeight * 0.07,
                                decoration: BoxDecoration(
                                  color: PrimaryColor.primary_01,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/logout/logout.svg',
                                    width: iconSize.largeIcon(context),
                                  ),
                                ),
                              ),

                              SizedBox(
                                  width: SpacingUtil.spacingWidth12(context)),

                              // Log out text
                              Text(
                                'Đăng xuất tài khoản',
                                textAlign: TextAlign.center,
                                style: TextStyleCustom.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
