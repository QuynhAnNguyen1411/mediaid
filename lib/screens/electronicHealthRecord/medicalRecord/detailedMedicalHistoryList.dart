import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/detailedExaminationResults.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/generalRecordList.dart';
import '../../../api/electronicHealthRecordAPI/medicalRecordAPI/medicalRecord_api.dart';
import '../../../design_system/button/button.dart';
import '../../../design_system/color/neutral_color.dart';
import '../../../design_system/input_field/text_input.dart';
import '../../../models/electronicHealthRecordModel/medicalRecordModel/generalRecordForm.dart';
import '../../../util/commonUtil.dart';
import '../../../util/spacingStandards.dart';
import '../electronicHealthRecord.dart';

class DetailedRecordList extends StatefulWidget {
  final String detailedRecordID;

  const DetailedRecordList({super.key, required this.detailedRecordID});

  @override
  State<StatefulWidget> createState() {
    return _DetailedRecordListState();
  }
}

class _DetailedRecordListState extends State<DetailedRecordList> {
  Color getStatusColor(String statusLabel) {
    switch (statusLabel) {
      case 'Đã khám':
        return StatusColor.informationFull;
      case 'Cần tái khám':
        return StatusColor.warningFull;
      case 'Đang khám':
        return StatusColor.successFull;
      case 'Đã hủy':
        return StatusColor.errorFull;
      default:
        return NeutralColor.neutral_05;
    }
  }

  GeneralRecordForm? generalRecord;

  Future<GeneralRecordForm?> _loadGeneralRecordData() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      var generalRecords =
          await MedicalRecordApi.getDetailedExaminationHistoryData(
              widget.detailedRecordID);
      return generalRecords;
    } catch (e) {
      print("Error loading patient data: $e");
      return null;
    }
  }

  Color getExaminationTypeColor(String examinationType) {
    switch (examinationType) {
      case 'Chẩn đoán sơ bộ':
        return StatusColor.informationBackground;
      case 'Chẩn đoán hình ảnh':
        return StatusColor.successBackground;
      case 'Thủ thuật y tế và can thiệp':
        return StatusColor.errorBackground;
      case 'Xét nghiệm chức năng':
        return StatusColor.warningBackground;
      default:
        return NeutralColor.neutral_02;
    }
  }

  Color getExaminationTypeBarColor(String examinationTypeBar) {
    switch (examinationTypeBar) {
      case 'Chẩn đoán sơ bộ':
        return StatusColor.informationFull;
      case 'Chẩn đoán hình ảnh':
        return StatusColor.successFull;
      case 'Thủ thuật y tế và can thiệp':
        return StatusColor.errorFull;
      case 'Xét nghiệm chức năng':
        return StatusColor.warningFull;
      default:
        return NeutralColor.neutral_05;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final iconSize = IconSizeUtil();
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Điều hướng về màn hình bạn muốn
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ElectronicHealthRecord(initialIndex: 1),)
              );
            },
          ),
          title: Text(
            'Chi tiết lịch sử khám',
            style: TextStyleCustom.heading_2a
                .copyWith(color: PrimaryColor.primary_10),
          ),
          backgroundColor: PrimaryColor.primary_01,
          elevation: 4.0,
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              SpacingUtil.spacingWidth16(context),
              SpacingUtil.spacingHeight24(context),
              SpacingUtil.spacingWidth16(context),
              SpacingUtil.spacingHeight24(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin khám bệnh
              FutureBuilder<GeneralRecordForm?>(
                  future: _loadGeneralRecordData(),
                  builder: (context, snapshot) {
                    // Kiểm tra trạng thái kết nối với Future
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Nếu dữ liệu đang được tải, hiển thị loading indicator
                      return Center(child: CircularProgressIndicator());
                    }
                    // Nếu có lỗi xảy ra khi tải dữ liệu
                    else if (snapshot.hasError) {
                      return Center(
                          child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                    }
                    // Nếu không có dữ liệu (null)
                    else if (!snapshot.hasData) {
                      return Center(child: Text('Không có dữ liệu bệnh nhân'));
                    }
                    var detailedRecordData = snapshot.data!;
                    TextEditingController _diseaseConclusionController =
                        TextEditingController(
                            text: detailedRecordData.diseaseConclusion);

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // Thông tin khám bệnh
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Thông tin khám bệnh',
                                    style: TextStyleCustom.heading_3a.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  Container(
                                    height: screenHeight * 0.04,
                                    width: screenWidth * 0.3,
                                    decoration: BoxDecoration(
                                      color: getStatusColor(
                                          detailedRecordData.statusLabel),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        detailedRecordData.statusLabel,
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: PrimaryColor.primary_00),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: SpacingUtil.spacingHeight16(context)),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: PrimaryColor.primary_00,
                                    border: Border.all(
                                      color: PrimaryColor.primary_10,
                                      width: 1.2,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                      SpacingUtil.spacingWidth12(context),
                                      vertical: SpacingUtil.spacingHeight12(
                                          context)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/home/calendar.svg',
                                            width: iconSize.mediumIcon(context),
                                          ),
                                          SizedBox(width: SpacingUtil.spacingWidth8(context)),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                detailedRecordData
                                                    .conclusionTime),
                                            style: TextStyleCustom.bodySmall
                                                .copyWith(
                                                    color: PrimaryColor
                                                        .primary_10),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/home/hospital.svg',
                                            width: iconSize.mediumIcon(context),
                                          ),
                                          SizedBox(width: SpacingUtil.spacingWidth8(context)),
                                          Text(
                                            detailedRecordData.medicalFacility,
                                            style: TextStyleCustom.bodySmall
                                                .copyWith(
                                                    color: PrimaryColor
                                                        .primary_10),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/home/doctor.svg',
                                            width: iconSize.mediumIcon(context),
                                          ),
                                          SizedBox(width: SpacingUtil.spacingWidth8(context)),
                                          Text(
                                            detailedRecordData.doctorName,
                                            style: TextStyleCustom.bodySmall
                                                .copyWith(
                                                    color: PrimaryColor
                                                        .primary_10),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight24(context)),
                          // Danh sách dịch vụ thực hiện
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Danh sách dịch vụ thực hiện',
                                style: TextStyleCustom.heading_3a
                                    .copyWith(color: PrimaryColor.primary_10),
                              ),
                              SizedBox(height: SpacingUtil.spacingHeight16(context)),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: detailedRecordData
                                      .detailedRecordList?.length,
                                  itemBuilder: (context, index) {
                                    var detailedRecord = detailedRecordData
                                        .detailedRecordList?[index];
                                    String formattedDay = DateFormat('dd')
                                        .format(
                                            detailedRecord!.examinationTime);
                                    String formattedMonth = DateFormat('MM')
                                        .format(detailedRecord.examinationTime);
                                    String formattedTime =
                                        DateFormat('dd/MM/yyyy HH:mm').format(
                                            detailedRecord.examinationTime);
                                    return Container(
                                      margin: EdgeInsets.only(bottom: SpacingUtil.spacingHeight16(context)),
                                      padding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth16(context),
                                          vertical: SpacingUtil.spacingHeight16(context)),
                                      decoration: BoxDecoration(
                                        color: PrimaryColor.primary_00,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: PrimaryColor.primary_05,
                                          width: 1.2,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: screenWidth * 0.2,
                                                height: screenHeight * 0.2,
                                                decoration: BoxDecoration(
                                                    color:
                                                        getExaminationTypeColor(
                                                            detailedRecord
                                                                .examinationType),
                                                    border: Border(
                                                        left: BorderSide(
                                                      color: getExaminationTypeBarColor(
                                                          detailedRecord
                                                              .examinationType),
                                                      width: screenWidth * 0.01,
                                                    ))),
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        formattedDay,
                                                        style: TextStyleCustom
                                                            .heading_3a
                                                            .copyWith(
                                                                color: PrimaryColor
                                                                    .primary_10),
                                                      ),
                                                      SizedBox(
                                                          height: screenHeight *
                                                              0.005),
                                                      Text(
                                                        'Tháng $formattedMonth',
                                                        style: TextStyleCustom
                                                            .bodySmall
                                                            .copyWith(
                                                                color: PrimaryColor
                                                                    .primary_10),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: screenWidth * 0.015),
                                              Expanded(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                screenWidth *
                                                                    0.02),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          detailedRecord
                                                              .examinationType,
                                                          style: TextStyleCustom
                                                              .bodySmall
                                                              .copyWith(
                                                                  color: PrimaryColor
                                                                      .primary_10),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.009),
                                                        Text(
                                                          detailedRecord
                                                              .examinationName,
                                                          style: TextStyleCustom
                                                              .heading_3b
                                                              .copyWith(
                                                                  color: PrimaryColor
                                                                      .primary_10),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.02),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/icons/home/calendar.svg',
                                                                  width:
                                                                      screenWidth *
                                                                          0.055,
                                                                  height:
                                                                      screenHeight *
                                                                          0.025,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        screenWidth *
                                                                            0.02),
                                                                Text(
                                                                  formattedTime,
                                                                  style: TextStyleCustom
                                                                      .bodySmall
                                                                      .copyWith(
                                                                          color:
                                                                              PrimaryColor.primary_10),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    screenHeight *
                                                                        0.01),
                                                            Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/icons/home/hospital.svg',
                                                                  width:
                                                                      screenWidth *
                                                                          0.055,
                                                                  height:
                                                                      screenHeight *
                                                                          0.025,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        screenWidth *
                                                                            0.02),
                                                                Text(
                                                                  detailedRecord.clinicNumber,
                                                                  style: TextStyleCustom
                                                                      .bodySmall
                                                                      .copyWith(
                                                                          color:
                                                                              PrimaryColor.primary_10),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    screenHeight *
                                                                        0.01),
                                                            Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/icons/electronicHealthRecord/notes.svg',
                                                                  width:
                                                                      screenWidth *
                                                                          0.055,
                                                                  height:
                                                                      screenHeight *
                                                                          0.025,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        screenWidth *
                                                                            0.02),
                                                                Container(
                                                                  constraints: BoxConstraints(
                                                                      maxWidth:
                                                                          screenWidth *
                                                                              0.5),
                                                                  child: Text(
                                                                    detailedRecord
                                                                        .examinationNote,
                                                                    style: TextStyleCustom
                                                                        .bodySmall
                                                                        .copyWith(
                                                                            color:
                                                                                PrimaryColor.primary_10),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    softWrap:
                                                                        true,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                          CustomButton(
                                            type: ButtonType.standard,
                                            state: ButtonState.fill1,
                                            width: double.infinity,
                                            height: SpacingUtil.spacingHeight56(context),
                                            text: 'Xem chi tiết',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DetailedExamResults(detailedRecordID: detailedRecord.detailedRecordID,),
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  })
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Kết luận
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kết luận',
                                style: TextStyleCustom.heading_3a
                                    .copyWith(color: PrimaryColor.primary_10),
                              ),
                              CustomTextInput(
                                type: TextFieldType.text,
                                state: TextFieldState.disabled,
                                controller: _diseaseConclusionController,
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Đơn thuốc
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Đơn thuốc điều trị',
                                    style: TextStyleCustom.heading_3a.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  CustomButton(
                                    type: ButtonType.standard,
                                    state: ButtonState.text,
                                    text: "Xem chi tiết",
                                    width: screenWidth * 0.03,
                                    height: screenHeight * 0.06,
                                    onPressed: () {
                                      showPrescriptionDetails();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: detailedRecordData
                                      .detailedMedicationList?.length,
                                  itemBuilder: (context, index) {
                                    var detailedMedicineRecord =
                                        detailedRecordData
                                            .detailedMedicationList?[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
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
                                                  children: [
                                                    Container(
                                                      width: 32,
                                                      height: 32,
                                                      decoration: BoxDecoration(
                                                        color: PrimaryColor
                                                            .primary_01,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        '${index + 1}',
                                                        style: TextStyleCustom
                                                            .bodyLarge
                                                            .copyWith(
                                                                color: PrimaryColor
                                                                    .primary_10),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width:
                                                            screenWidth * 0.02),
                                                    Text(
                                                      detailedMedicineRecord!
                                                          .medicineName,
                                                      style: TextStyleCustom
                                                          .bodyLarge
                                                          .copyWith(
                                                              color: PrimaryColor
                                                                  .primary_10),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Hướng dẫn điều trị
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hướng dẫn điều trị',
                                style: TextStyleCustom.heading_3a
                                    .copyWith(color: PrimaryColor.primary_10),
                              ),
                              CustomTextInput(
                                type: TextFieldType.text,
                                state: TextFieldState.disabled,
                                controller: _diseaseConclusionController,
                              )
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Thanh toán dịch vụ
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thanh toán dịch vụ',
                                style: TextStyleCustom.heading_3a
                                    .copyWith(color: PrimaryColor.primary_10),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: detailedRecordData
                                      .detailedRecordList?.length,
                                  itemBuilder: (context, index) {
                                    var detailedRecord = detailedRecordData
                                        .detailedRecordList?[index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          detailedRecord!.examinationName,
                                          style: TextStyleCustom.bodyLarge
                                              .copyWith(
                                                  color:
                                                      PrimaryColor.primary_10),
                                        ),
                                        Text(
                                            detailedRecord.value
                                                .toStringAsFixed(1),
                                            style: TextStyleCustom.heading_3c
                                                .copyWith(
                                                    color: NeutralColor
                                                        .neutral_07)),
                                      ],
                                    );
                                  })
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          )),
    );
  }

  void showPrescriptionDetails() {
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          double iconSize = screenWidth * 0.08;
          return Scaffold(
              backgroundColor: PrimaryColor.primary_00,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.04,
                      screenHeight * 0.08,
                      screenWidth * 0.04,
                      screenHeight * 0.02),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chi tiết đơn thuốc',
                            style: TextStyleCustom.heading_2b
                                .copyWith(color: PrimaryColor.primary_10),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close,
                                  size: iconSize,
                                  color: StatusColor.errorFull)),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      FutureBuilder<GeneralRecordForm?>(
                          future: _loadGeneralRecordData(),
                          builder: (context, snapshot) {
                            // Kiểm tra trạng thái kết nối với Future
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Nếu dữ liệu đang được tải, hiển thị loading indicator
                              return Center(child: CircularProgressIndicator());
                            }
                            // Nếu có lỗi xảy ra khi tải dữ liệu
                            else if (snapshot.hasError) {
                              return Center(
                                  child:
                                      Text('Có lỗi xảy ra: ${snapshot.error}'));
                            }
                            // Nếu không có dữ liệu (null)
                            else if (!snapshot.hasData) {
                              return Center(
                                  child: Text('Không có dữ liệu bệnh nhân'));
                            }
                            var detailedRecordData = snapshot.data!;
                            TextEditingController diseaseConclusionController =
                                TextEditingController(
                                    text: detailedRecordData.diseaseConclusion);
                            return SizedBox(
                              height: screenHeight,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Chẩn đoán chính',
                                        style: TextStyleCustom.heading_3a
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      CustomTextInput(
                                        type: TextFieldType.text,
                                        state: TextFieldState.disabled,
                                        controller: diseaseConclusionController,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Danh sách các loại thuốc điều trị',
                                        style: TextStyleCustom.heading_3a
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: detailedRecordData
                                              .detailedMedicationList?.length,
                                          itemBuilder: (context, index) {
                                            var detailedMedicineRecord =
                                                detailedRecordData
                                                        .detailedMedicationList?[
                                                    index];
                                            TextEditingController
                                                medicineNameController =
                                                TextEditingController(
                                                    text: detailedMedicineRecord
                                                        ?.medicineName);
                                            TextEditingController
                                                instructionsController =
                                                TextEditingController(
                                                    text: detailedMedicineRecord
                                                        ?.instructions);
                                            TextEditingController
                                                unitController =
                                                TextEditingController(
                                                    text: detailedMedicineRecord
                                                        ?.unit);
                                            // Gán giá trị double vào TextEditingController
                                            TextEditingController
                                                dosageController =
                                                TextEditingController(
                                              text: detailedMedicineRecord!
                                                  .dosage
                                                  .toString(), // Chuyển đổi từ double sang String
                                            );
                                            // Khi lấy giá trị từ TextField và chuyển lại thành double sử dụng CommonUtil
                                            double? dosageValue = CommonUtil
                                                .convertStringToDouble(
                                                    dosageController.text);
                                            return Container(
                                              padding: EdgeInsets.all(16),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color:
                                                      PrimaryColor.primary_10,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextInput(
                                                    type: TextFieldType.text,
                                                    state:
                                                        TextFieldState.disabled,
                                                    label: 'Tên loại thuốc',
                                                    controller:
                                                        medicineNameController,
                                                  ),
                                                  CustomTextInput(
                                                    type: TextFieldType.text,
                                                    state:
                                                        TextFieldState.disabled,
                                                    label: 'Liều lượng',
                                                    controller:
                                                        dosageController,
                                                  ),
                                                  CustomTextInput(
                                                    type: TextFieldType.text,
                                                    state:
                                                        TextFieldState.disabled,
                                                    label: 'Đơn vị',
                                                    controller: unitController,
                                                  ),
                                                  CustomTextInput(
                                                    type: TextFieldType.text,
                                                    state:
                                                        TextFieldState.disabled,
                                                    label: 'Hướng dẫn sử dụng',
                                                    controller:
                                                        instructionsController,
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ));
        });
  }
}
