import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';

import '../../design_system/button/button.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class ClinicOrders extends StatefulWidget {
  const ClinicOrders({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClinicOrdersState();
  }
}

class _ClinicOrdersState extends State<ClinicOrders> {
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
            'Xếp số phòng khám',
            style: TextStyleCustom.heading_2a
                .copyWith(color: PrimaryColor.primary_10),
          ),
          backgroundColor: PrimaryColor.primary_01,
          elevation: 4.0,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.04),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.78,
                    height: screenHeight * 0.37,
                    child: CircularProgressIndicator(
                      value: 0.5,
                      backgroundColor: NeutralColor.neutral_01,
                      strokeWidth: screenWidth * 0.07,
                      strokeAlign: BorderSide.strokeAlignInside,
                      semanticsValue: '50%',
                      strokeCap: StrokeCap.round,
                      valueColor: AlwaysStoppedAnimation(
                          LinearGradient(
                            colors: [
                              Color(0xFFCCDEE7),
                              Color(0xFFCCDEE7),
                              Color(0xFF015C89),
                            ],
                            stops: [0.0, 0.12, 0.88],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).colors.last
                      ),
                    ),
                  ),
                  Text('50/70',
                      style: GoogleFonts.quicksand(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                'Phòng khám Đầu mặt cổ',
                style: TextStyleCustom.heading_2b
                    .copyWith(color: PrimaryColor.primary_10),
              ),
              SizedBox(height: screenHeight * 0.02),
              Spacer(),
              CustomButton(
                type: ButtonType.standard,
                state: ButtonState.fill1,
                text: 'Xếp số thứ tự tiếp theo',
                width: double.infinity,
                height: screenHeight * 0.06,
                onPressed: () {},
              ),
              SizedBox(height: screenHeight * 0.03)
            ],
          )),
    );
  }
}
