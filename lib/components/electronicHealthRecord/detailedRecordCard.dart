// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
// import 'package:mediaid/design_system/button/button.dart';
// import 'package:mediaid/design_system/color/neutral_color.dart';
// import 'package:mediaid/design_system/color/primary_color.dart';
// import 'package:mediaid/design_system/color/status_color.dart';
// import 'package:mediaid/design_system/textstyle/textstyle.dart';
//
// import '../../api/electronicHealthRecordAPI/medicalRecordAPI/medicalRecord_api.dart';
// import '../../models/electronicHealthRecordModel/medicalRecordModel/detailedRecordForm.dart';
//
// class DetailedRecordCard extends StatefulWidget {
//   final DetailedRecordCardForm detailedRecord;
//
//   const DetailedRecordCard({super.key, required this.detailedRecord});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _DetailedRecordCardState();
//   }
// }
//
// class _DetailedRecordCardState extends State<DetailedRecordCard> {
//   late Future<List<DetailedRecordCardForm>> detailedRecordCardList;
//
//   // Load data
//   Future<List<DetailedRecordCardForm>> _loadDetailedRecordCardData() async {
//     var box = await Hive.openBox('loginBox');
//     String accountID = await box.get('accountID');
//     return await MedicalRecordApi.getDetailedExaminationHistoryData(accountID);
//   }
//   @override
//   void initState() {
//     super.initState();
//     detailedRecordCardList = _loadDetailedRecordCardData();
//   }
//   Color getExaminationTypeColor(String examinationType) {
//     switch (examinationType) {
//       case 'Siêu âm':
//       case 'Chụp XQuang':
//       case 'Chụp CT ':
//       case 'Chụp mạch Angiography':
//       case 'Chụp MRI':
//         return StatusColor.informationBackground;
//       case 'Chọc tế bào':
//       case 'Sinh thiết':
//       case 'Nội soi':
//         return StatusColor.warningBackground;
//       case 'Xét nghiệm máu':
//       case 'Xét nghiệm nước tiểu':
//       case 'Xét nghiệm vi khuẩn, virus':
//       case 'Điện tim':
//       case 'Đo mật độ xương':
//       case 'Đo chức năng hô hấp':
//       case 'Test dị ứng':
//         return StatusColor.successBackground;
//       default:
//         return NeutralColor.neutral_02;
//     }
//   }
//
//   Color getExaminationTypeBarColor(String examinationTypeBar) {
//     switch (examinationTypeBar) {
//       case 'Siêu âm':
//       case 'Chụp XQuang':
//       case 'Chụp CT ':
//       case 'Chụp mạch Angiography':
//       case 'Chụp MRI':
//         return StatusColor.informationFull;
//       case 'Chọc tế bào':
//       case 'Sinh thiết':
//       case 'Nội soi':
//         return StatusColor.warningFull;
//       case 'Xét nghiệm máu':
//       case 'Xét nghiệm nước tiểu':
//       case 'Xét nghiệm vi khuẩn, virus':
//       case 'Điện tim':
//       case 'Đo mật độ xương':
//       case 'Đo chức năng hô hấp':
//       case 'Test dị ứng':
//         return StatusColor.successFull;
//       default:
//         return NeutralColor.neutral_02;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: PrimaryColor.primary_00,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FutureBuilder(
//                 future: detailedRecordCardList,
//                 builder: (context, snapshot) {
//                   // Kiểm tra trạng thái kết nối với Future
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     // Nếu dữ liệu đang được tải, hiển thị loading indicator
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   // Nếu có lỗi xảy ra khi tải dữ liệu
//                   else if (snapshot.hasError) {
//                     return Center(
//                         child: Text('Có lỗi xảy ra: ${snapshot.error}'));
//                   }
//                   // Nếu không có dữ liệu (null)
//                   else if (!snapshot.hasData) {
//                     return Center(child: Text('Không có dữ liệu bệnh nhân'));
//                   }
//                   var detailedMedicalRecordData = snapshot.data;
//                   return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: detailedMedicalRecordData?.length,
//                       itemBuilder: (context, index) {
//                         var detailedRecord = detailedMedicalRecordData?[index];
//                         String formattedDay = DateFormat('dd').format(detailedRecord!.examinationTime);
//                         String formattedMonth = DateFormat('MM').format(detailedRecord.examinationTime);
//                         String formattedTime = DateFormat('dd/MM/yyyy HH:mm').format(detailedRecord.examinationTime);
//                         return Container(
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: PrimaryColor.primary_00,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: PrimaryColor.primary_05,
//                               width: 1,
//                             ),
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: screenWidth * 0.2,
//                                     height: screenHeight * 0.2,
//                                     decoration: BoxDecoration(
//                                         color: getExaminationTypeColor(detailedRecord.examinationType),
//                                         border: Border(
//                                             left: BorderSide(
//                                               color: getExaminationTypeBarColor(detailedRecord.examinationType),
//                                               width: screenWidth * 0.005,
//                                             ))),
//                                     child: Center(
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             formattedDay,
//                                             style: TextStyleCustom.heading_3a
//                                                 .copyWith(color: PrimaryColor.primary_10),
//                                           ),
//                                           SizedBox(height: screenHeight * 0.005),
//                                           Text(
//                                             'Tháng$formattedMonth',
//                                             style: TextStyleCustom.bodySmall
//                                                 .copyWith(color: PrimaryColor.primary_10),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: screenWidth * 0.015),
//                                   Expanded(
//                                     child: Padding(
//                                         padding:
//                                         EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               children: [
//                                                 Column(
//                                                   children: [
//                                                     Text(
//                                                       detailedRecord.examinationType,
//                                                       style: TextStyleCustom.bodySmall
//                                                           .copyWith(color: PrimaryColor.primary_10),
//                                                     ),
//                                                     SizedBox(height: screenHeight * 0.009),
//                                                     Text(
//                                                       detailedRecord.examinationName,
//                                                       style: TextStyleCustom.heading_3b
//                                                           .copyWith(color: PrimaryColor.primary_10),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 CircleAvatar(
//                                                   radius: 45,
//                                                   backgroundColor: PrimaryColor.primary_05,
//                                                   child: Text('61',style: TextStyleCustom.heading_2b.copyWith(color: PrimaryColor.primary_00)),
//                                                 )
//                                               ],
//                                             ),
//                                             SizedBox(height: screenHeight * 0.02),
//                                             Column(
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                       'assets/icons/home/calendar.svg',
//                                                       width: screenWidth * 0.055,
//                                                       height: screenHeight * 0.025,
//                                                     ),
//                                                     SizedBox(width: screenWidth * 0.02),
//                                                     Text(
//                                                       formattedTime,
//                                                       style: TextStyleCustom.bodySmall
//                                                           .copyWith(color: PrimaryColor.primary_10),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: screenHeight * 0.01),
//                                                 Row(
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                       'assets/icons/home/hospital.svg',
//                                                       width: screenWidth * 0.055,
//                                                       height: screenHeight * 0.025,
//                                                     ),
//                                                     SizedBox(width: screenWidth * 0.02),
//                                                     Text(
//                                                       detailedRecord.examinationLocation,
//                                                       style: TextStyleCustom.bodySmall
//                                                           .copyWith(color: PrimaryColor.primary_10),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: screenHeight * 0.01),
//                                                 Row(
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                       'assets/icons/electronicHealthRecord/notes.svg',
//                                                       width: screenWidth * 0.055,
//                                                       height: screenHeight * 0.025,
//                                                     ),
//                                                     SizedBox(width: screenWidth * 0.02),
//                                                     Container(
//                                                       constraints: BoxConstraints(
//                                                           maxWidth: screenWidth * 0.5),
//                                                       child: Text(
//                                                         detailedRecord.examinationNote,
//                                                         style: TextStyleCustom.bodySmall.copyWith(
//                                                             color: PrimaryColor.primary_10),
//                                                         overflow: TextOverflow.clip,
//                                                         softWrap: true,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         )),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: screenHeight * 0.015),
//                               CustomButton(
//                                 type: ButtonType.standard,
//                                 state: ButtonState.fill1,
//                                 width: double.infinity,
//                                 height: screenHeight * 0.06,
//                                 text: 'Xem chi tiết',
//                                 onPressed: () {},
//                               )
//                             ],
//                           ),
//                         );
//                       });
//                 }
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// }
//
