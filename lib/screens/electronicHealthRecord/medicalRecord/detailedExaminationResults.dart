import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import '../../../api/electronicHealthRecordAPI/medicalRecordAPI/medicalRecord_api.dart';
import '../../../models/electronicHealthRecordModel/medicalRecordModel/detailedRecordForm.dart';
import '../../../util/spacingStandards.dart';


class DetailedExamResults extends StatefulWidget {
  final String detailedRecordID;

  const DetailedExamResults({super.key, required this.detailedRecordID});

  @override
  State<StatefulWidget> createState() {
    return _DetailedExamResultsState();
  }
}

class _DetailedExamResultsState extends State<DetailedExamResults> {

  Future<DetailedRecordForm?> _loadDetailedResultsData() async {
    await Future.delayed(const Duration(seconds: 3));
    try {

      var detailedResults = await MedicalRecordApi.getDetailedExaminationResultsData(
          widget.detailedRecordID);
      return detailedResults;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppBar(
          title: Text(
            'Chi tiết kết quả khám',
            style: TextStyleCustom.heading_2a
                .copyWith(color: PrimaryColor.primary_10),
          ),
          backgroundColor: PrimaryColor.primary_01,
          elevation: 4.0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                SpacingUtil.spacingWidth16(context),
                SpacingUtil.spacingHeight24(context),
                SpacingUtil.spacingWidth16(context),
                SpacingUtil.spacingHeight24(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin khám bệnh
              FutureBuilder(
                  future: _loadDetailedResultsData(),
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
                    var detailedResultData = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thông tin dịch vụ',
                                style: TextStyleCustom.heading_3a.copyWith(
                                    color: PrimaryColor.primary_10),
                              ),
                              SizedBox(height: SpacingUtil.spacingHeight16(context)),
                              Text(detailedResultData.examinationName,style: TextStyleCustom.heading_2a.copyWith(
                                  color: PrimaryColor.primary_10),),
                            ],
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight24(context)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/home/calendar.svg',
                                        width: iconSize.mediumIcon(context),
                                      ),
                                      SizedBox(width: SpacingUtil.spacingWidth12(context)),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ngày khám',
                                            style: TextStyleCustom.bodyLarge.copyWith(
                                                color: PrimaryColor.primary_10),
                                          ),
                                          SizedBox(height: SpacingUtil.spacingHeight8(context)),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                detailedResultData.examinationTime),
                                            style: TextStyleCustom.heading_3b.copyWith(color: PrimaryColor.primary_10),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/home/calendar.svg',
                                        width: iconSize.mediumIcon(context),
                                      ),
                                      SizedBox(width: SpacingUtil.spacingWidth12(context)),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Giờ khám',
                                            style: TextStyleCustom.bodyLarge.copyWith(
                                                color: PrimaryColor.primary_10),
                                          ),
                                          SizedBox(height: SpacingUtil.spacingHeight8(context)),
                                          Text(
                                            DateFormat('HH:mm').format(
                                                detailedResultData.examinationTime),
                                            style: TextStyleCustom.heading_3b
                                                .copyWith(
                                                color: PrimaryColor
                                                    .primary_10),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight16(context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/home/calendar.svg',
                                width: iconSize.mediumIcon(context),
                              ),
                              SizedBox(width: SpacingUtil.spacingWidth12(context)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phòng khám',
                                    style: TextStyleCustom.bodyLarge.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  SizedBox(height: SpacingUtil.spacingHeight8(context)),
                                  Text(
                                    '${detailedResultData.clinicNumber}-${detailedResultData.examinationLocation}',
                                    style: TextStyleCustom.heading_3b
                                        .copyWith(
                                        color: PrimaryColor
                                            .primary_10),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight16(context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/home/calendar.svg',
                                width: iconSize.mediumIcon(context),
                              ),
                              SizedBox(width: SpacingUtil.spacingWidth12(context)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ghi chú',
                                    style: TextStyleCustom.bodyLarge.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  SizedBox(height: SpacingUtil.spacingHeight8(context)),
                                  Text(detailedResultData.examinationNote,
                                    style: TextStyleCustom.heading_3b
                                        .copyWith(
                                        color: PrimaryColor
                                            .primary_10),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight16(context)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kết quả dịch vụ',
                                style: TextStyleCustom.heading_3a.copyWith(
                                    color: PrimaryColor.primary_10),
                              ),
                              SizedBox(height: SpacingUtil.spacingHeight16(context)),
                              Text(
                                detailedResultData.testPhoto,
                              ),
                            ],
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight24(context)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thanh toán dịch vụ',
                                style: TextStyleCustom.heading_3a.copyWith(
                                    color: PrimaryColor.primary_10),
                              ),
                              SizedBox(height: SpacingUtil.spacingHeight16(context)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    detailedResultData.examinationName,
                                    style: TextStyleCustom.bodyLarge.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                  Text(
                                    detailedResultData.value.toString(),
                                    style: TextStyleCustom.bodyLarge.copyWith(
                                        color: PrimaryColor.primary_10),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          )),
      )
    );
  }
}
