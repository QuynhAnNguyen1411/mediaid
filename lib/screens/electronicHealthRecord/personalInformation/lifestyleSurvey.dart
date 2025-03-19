import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/neutral_color.dart';

import '../../../api/electronicHealthRecord/lifestyleSurvey_api.dart';
import '../../../design_system/button/button.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/input_field/text_input.dart';
import '../../../design_system/textstyle/textstyle.dart';
import '../../../models/electronicHealthRecord/personalInformation/workingEnvironment.dart';
import '../../../routes.dart';

class LifestyleSurvey extends StatefulWidget{
  const LifestyleSurvey({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LifestyleSurveyState();
  }
}

class _LifestyleSurveyState extends State<LifestyleSurvey>{
  final TextEditingController noteWorkingEnvironmentController = TextEditingController();

  // Danh sách chứa trạng thái của từng checkbox
  List<bool> isCheckedList = [false, false, false, false, false, false];

  // Dropdown
  int? _selectedMoitruonglamviecId;
  late List<WorkingEnvironment> _moiTruongLamViecList = [];

  Future<void> _fetchDropdownData() async {
    try {
      Map<String, List<Object>>? response =
      await LifestyleSurveyApi.getStaticDataForLifestyleSurvey();

      if (response != null) {
        print("a");
        setState(() {
          _moiTruongLamViecList = (response['danToc'] as List<WorkingEnvironment>).toList();
        });

        print("✅ Đã cập nhật danh sách Dân tộc: $_moiTruongLamViecList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
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
                  'Khảo sát lối sống',
                  style: TextStyleCustom.heading_2a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lối sống người bệnh", style: TextStyleCustom.heading_3a.copyWith(color: PrimaryColor.primary_10)),
                    SizedBox(height: screenHeight * 0.015),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01, vertical: screenHeight * 0.02),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: NeutralColor.neutral_04,
                          width: screenWidth * 0.003,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckedList[0] = !isCheckedList[0];
                                  });
                                },
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    value: isCheckedList[0],
                                    activeColor: PrimaryColor.primary_05,
                                    checkColor: PrimaryColor.primary_00,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[0] = value!;
                                      });
                                    },
                                    side: BorderSide(
                                      color: NeutralColor.neutral_06,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                child: Text(
                                  "Sử dụng chất kích thích (thuốc lá, ma túy, thuốc lá điện tử)",
                                  style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckedList[1] = !isCheckedList[1];
                                  });
                                },
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    value: isCheckedList[1],
                                    activeColor: PrimaryColor.primary_05,
                                    checkColor: PrimaryColor.primary_00,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[1] = value!;
                                      });
                                    },
                                    side: BorderSide(
                                      color: NeutralColor.neutral_06,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                child: Text(
                                  "Uống nhiều rượu bia",
                                  style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckedList[2] = !isCheckedList[2];
                                  });
                                },
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    value: isCheckedList[2],
                                    activeColor: PrimaryColor.primary_05,
                                    checkColor: PrimaryColor.primary_00,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[2] = value!;
                                      });
                                    },
                                    side: BorderSide(
                                      color: NeutralColor.neutral_06,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                child: Text(
                                  "Ăn mặn",
                                  style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckedList[3] = !isCheckedList[3];
                                  });
                                },
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    value: isCheckedList[3],
                                    activeColor: PrimaryColor.primary_05,
                                    checkColor: PrimaryColor.primary_00,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[3] = value!;
                                      });
                                    },
                                    side: BorderSide(
                                      color: NeutralColor.neutral_06,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                child: Text(
                                  "Stress tâm lý",
                                  style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckedList[4] = !isCheckedList[4];
                                  });
                                },
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    value: isCheckedList[4],
                                    activeColor: PrimaryColor.primary_05,
                                    checkColor: PrimaryColor.primary_00,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[4] = value!;
                                      });
                                    },
                                    side: BorderSide(
                                      color: NeutralColor.neutral_06,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                child: Text(
                                  "Thường xuyên thiếu ngủ",
                                  style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isCheckedList[5] = !isCheckedList[5];
                                  });
                                },
                                child: Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                    value: isCheckedList[5],
                                    activeColor: PrimaryColor.primary_05,
                                    checkColor: PrimaryColor.primary_00,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isCheckedList[5] = value!;
                                      });
                                    },
                                    side: BorderSide(
                                      color: NeutralColor.neutral_06,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                child: Text(
                                  "Ít vận động thể dục hoặc ngồi nhiều",
                                  style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Môi trường làm việc", style: TextStyleCustom.heading_3a.copyWith(color: PrimaryColor.primary_10)),
                    SizedBox(height: screenHeight * 0.015),
                    DropdownButtonFormField(
                      value: _selectedMoitruonglamviecId,
                      hint: Text(
                        'Chọn môi trường làm việc',
                        style: TextStyleCustom.bodySmall.copyWith(
                          color: NeutralColor.neutral_06,
                        ),
                      ),
                      isExpanded: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: NeutralColor.neutral_04,
                            width: screenWidth * 0.004,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: NeutralColor.neutral_04,
                            width: screenWidth * 0.004,
                          ),
                        ),
                      ),
                      dropdownColor: PrimaryColor.primary_00,
                      items: _moiTruongLamViecList.map((moiTruongLamViec) {
                        return DropdownMenuItem<int>(
                          value: moiTruongLamViec.workingEnvironmentID,
                          child: Text(
                            moiTruongLamViec.workingEnvironmentName,
                            style: TextStyleCustom.bodySmall
                                .copyWith(color: PrimaryColor.primary_10),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMoitruonglamviecId = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ghi chú", style: TextStyleCustom.heading_3a.copyWith(color: PrimaryColor.primary_10)),
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      hintText: 'Thêm tác nhân hoặc nguy cơ đáng ngại khác',
                      controller: noteWorkingEnvironmentController,
                      keyboardType: TextInputType.multiline,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomButton(
                  type: ButtonType.standard,
                  state: ButtonState.fill1 ,
                  text: "Hoàn thành",
                  width: double.infinity,
                  height: screenHeight * 0.06,
                  onPressed: () {
                    Navigator.pushNamed(context, MediaidRoutes.electronicHealthRecord);
                  }
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ],
        ),
      ),
    );
  }

}