import 'package:flutter/material.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/patientHistory_Common.dart';
import 'package:mediaid/screens/registration/registration.dart';

import '../../../components/electronicHealthRecord/medicalInformationCard.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thông tin bệnh nhân',
                      style: TextStyleCustom.heading_3a
                          .copyWith(color: PrimaryColor.primary_10),
                    ),
                    CustomButton(
                      type: ButtonType.iconOnly,
                      state: ButtonState.text,
                      icon: Icons.edit,
                      width: screenWidth * 0.08,
                      height: screenHeight * 0.04,
                      onPressed: () {
                        Registration();
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.0015),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: PrimaryColor.primary_00,
                      border: Border.all(
                        color: PrimaryColor.primary_10,
                        width: 1.0,
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.035,
                        vertical: screenHeight * 0.02),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Họ và tên',
                                style: TextStyleCustom.bodySmall
                                    .copyWith(color: PrimaryColor.primary_10)),
                            Text('Nguyễn Phương Trang',
                                style: TextStyleCustom.bodyLarge
                                    .copyWith(color: PrimaryColor.primary_10))
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('CMND/CMT',
                                style: TextStyleCustom.bodySmall
                                    .copyWith(color: PrimaryColor.primary_10)),
                            Text('036303001737',
                                style: TextStyleCustom.bodyLarge
                                    .copyWith(color: PrimaryColor.primary_10))
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Số thẻ BHYT',
                                style: TextStyleCustom.bodySmall
                                    .copyWith(color: PrimaryColor.primary_10)),
                            Text('1234567890',
                                style: TextStyleCustom.bodyLarge
                                    .copyWith(color: PrimaryColor.primary_10))
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Số điện thoại',
                                style: TextStyleCustom.bodySmall
                                    .copyWith(color: PrimaryColor.primary_10)),
                            Text('0867007653',
                                style: TextStyleCustom.bodyLarge
                                    .copyWith(color: PrimaryColor.primary_10))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin y tế cơ bản',
                  style: TextStyleCustom.heading_3a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: screenHeight * 0.0015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MedicalInformationCard(
                        svgAssetPath:
                            'assets/icons/electronicHealthRecord/medical_history.svg',
                        label: 'Tiểu sử y tế',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientHistory()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    Expanded(
                      child: MedicalInformationCard(
                        svgAssetPath:
                            'assets/icons/electronicHealthRecord/drug_history.svg',
                        label: 'Tiểu sử thuốc',
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.005),
                    Expanded(
                      child: MedicalInformationCard(
                        svgAssetPath:
                            'assets/icons/electronicHealthRecord/lifestyle.svg',
                        label: 'Lối sống',
                        onTap: () {},
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
