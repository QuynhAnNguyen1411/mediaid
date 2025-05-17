
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientInformation/updatePatientInformation.dart';
import '../../../api/electronicHealthRecordAPI/personalInformation_api.dart';
import '../../../components/electronicHealthRecord/medicalInformationCard.dart';
import '../../../models/electronicHealthRecordModel/personalInformation/personalInformationForm.dart';
import '../../../routes.dart';
import '../../../util/spacingStandards.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});
  @override
  State<StatefulWidget> createState() {
    return PersonalInformationState();
  }
}

class PersonalInformationState extends State<PersonalInformation> {
  PersonalInformationForm? patientData;
// Load thông tin bệnh nhân
  Future<PersonalInformationForm?> _loadPatientData() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      var box = await Hive.openBox('loginBox');
      var accountID = await box.get('accountID');
      var patient = await PersonalInformationApi.getPatientData(accountID);

      if (patient == null) {
        if (context.mounted) {
          Navigator.pushNamed(context, MediaidRoutes.registration);
        }
        return null;
      }

      return patient;
    } catch (e) {
      print("Error loading patient data: $e");
      return null;
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final iconSize = IconSizeUtil();
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        child: Column(
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
                      width: iconSize.mediumIcon(context),
                      height: iconSize.mediumIcon(context),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePatientInfo()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: SpacingUtil.spacingHeight16(context)),
                FutureBuilder<PersonalInformationForm?>(
                    future: _loadPatientData(),
                    builder: (context, snapshot){
                      // Kiểm tra trạng thái kết nối với Future
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Nếu dữ liệu đang được tải, hiển thị loading indicator
                        return Center(child: CircularProgressIndicator());
                      }
                      // Nếu có lỗi xảy ra khi tải dữ liệu
                      else if (snapshot.hasError) {
                        return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                      }
                      // Nếu không có dữ liệu (null)
                      else if (!snapshot.hasData) {
                        return Center(child: Text('Không có dữ liệu bệnh nhân'));
                      }
                      // Dữ liệu đã được tải thành công
                      var patientData = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: PrimaryColor.primary_00,
                                      border: Border.all(
                                        color: PrimaryColor.primary_10,
                                        width: 1.2,
                                      )
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: SpacingUtil.spacingWidth16(context),
                                        vertical: SpacingUtil.spacingHeight16(context)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Họ và tên',
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: PrimaryColor.primary_10)),
                                            Text(patientData!.patientName,
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10))
                                          ],
                                        ),
                                        SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('CMND/CMT',
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: PrimaryColor.primary_10)),
                                            Text(patientData.personalIdentifier,
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10))
                                          ],
                                        ),
                                        SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Số thẻ BHYT',
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: PrimaryColor.primary_10)),
                                            Text(patientData.healthInsurance,
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10))
                                          ],
                                        ),
                                        SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Số điện thoại',
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: PrimaryColor.primary_10)),
                                            Text(patientData.phoneNumber,
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
                          ],
                        ),
                      );
                    }
                ),
              ],
            ),
            SizedBox(height: SpacingUtil.spacingHeight24(context)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin y tế cơ bản',
                  style: TextStyleCustom.heading_3a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: SpacingUtil.spacingHeight16(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MedicalInformationCard(
                        svgAssetPath:
                        'assets/icons/electronicHealthRecord/medical_history.svg',
                        label: 'Tiền sử y tế',
                        onTap: () {
                          Navigator.pushNamed(context, MediaidRoutes.patientHistory);
                        },
                      ),
                    ),
                    SizedBox(width: SpacingUtil.spacingWidth8(context)),
                    Expanded(
                      child: MedicalInformationCard(
                        svgAssetPath:
                        'assets/icons/electronicHealthRecord/drug_history.svg',
                        label: 'Tiền sử thuốc',
                        onTap: () {
                          Navigator.pushNamed(context, MediaidRoutes.drugHistory);
                        },
                      ),
                    ),
                    SizedBox(width: SpacingUtil.spacingWidth8(context)),
                    Expanded(
                      child: MedicalInformationCard(
                        svgAssetPath:
                        'assets/icons/electronicHealthRecord/lifestyle.svg',
                        label: 'Lối sống',
                        onTap: () {
                          Navigator.pushNamed(context, MediaidRoutes.lifestyleSurvey);
                        },
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
