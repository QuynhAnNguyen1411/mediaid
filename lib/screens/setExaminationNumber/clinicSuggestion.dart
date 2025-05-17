import 'package:flutter/material.dart';

import '../../design_system/button/button.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class ClinicSuggestions extends StatefulWidget {
  const ClinicSuggestions({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClinicSuggestionsState();
  }
}

class _ClinicSuggestionsState extends State<ClinicSuggestions> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          title: Text(
            'Gợi ý phòng khám',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Image.asset(
                  'assets/images/setExaminationNumber/clinic_suggestions.png',
                  height: screenHeight * 0.5,
                  width: screenWidth * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Gợi ý phòng khám:',
                    style: TextStyleCustom.bodyLarge
                        .copyWith(color: PrimaryColor.primary_10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.015),
                        decoration: BoxDecoration(
                          color: PrimaryColor.primary_01,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Phòng khám Đầu mặt cổ',
                          style: TextStyleCustom.heading_3a
                              .copyWith(color: PrimaryColor.primary_10),
                        ),
                      ))
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.outline,
                      text: 'Không',
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: CustomButton(
                      type: ButtonType.standard,
                      state: ButtonState.fill1,
                      text: 'Đồng ý',
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.03)
            ],
          )),
    );
  }
}
