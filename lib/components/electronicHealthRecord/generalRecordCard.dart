// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
// import 'package:mediaid/design_system/button/button.dart';
// import 'package:mediaid/design_system/color/neutral_color.dart';
// import 'package:mediaid/design_system/color/primary_color.dart';
// import 'package:mediaid/design_system/textstyle/textstyle.dart';
// import '../../api/electronicHealthRecordAPI/medicalRecordAPI/medicalRecord_api.dart';
// import '../../models/electronicHealthRecordModel/medicalRecordModel/generalRecordForm.dart';
//
// class GeneralRecordCard extends StatefulWidget {
//   final GeneralRecordCardForm generalRecord;
//
//   const GeneralRecordCard({super.key, required this.generalRecord});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _GeneralRecordCardState();
//   }
// }
//
// class _GeneralRecordCardState extends State<GeneralRecordCard> {
//   late Future<List<GeneralRecordCardForm>> generalRecordCardList;
//
//   // Load data
//   Future<List<GeneralRecordCardForm>> _loadGeneralRecordCardData() async {
//     var box = await Hive.openBox('loginBox');
//     String accountID = await box.get('accountID');
//     return await MedicalRecordApi.getGeneralExaminationHistoryData(accountID);
//   }
//   @override
//   void initState() {
//     super.initState();
//     generalRecordCardList = _loadGeneralRecordCardData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: PrimaryColor.primary_00,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FutureBuilder(
//                 future: generalRecordCardList,
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
//                   var generalMedicalRecordData = snapshot.data;
//                   return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: generalMedicalRecordData?.length,
//                       itemBuilder: (context, index) {
//                         var generalRecord = generalMedicalRecordData?[index];
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
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Row(
//                                       children: [
//                                         SvgPicture.asset(
//                                           'assets/icons/home/disease_conclusion.svg',
//                                           width: screenWidth * 0.06,
//                                           height: screenHeight * 0.03,
//                                         ),
//                                         SizedBox(width: screenWidth * 0.02),
//                                         Container(
//                                           constraints: BoxConstraints(
//                                               maxWidth: screenWidth * 0.5),
//                                           child: Text(
//                                             generalRecord!.diseaseConclusion,
//                                             style: TextStyleCustom.heading_3a
//                                                 .copyWith(
//                                                     color: PrimaryColor
//                                                         .primary_10),
//                                             overflow: TextOverflow.clip,
//                                             softWrap: true,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     height: screenHeight * 0.04,
//                                     width: screenWidth * 0.3,
//                                     decoration: BoxDecoration(
//                                       color: generalRecord.statusColor,
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         generalRecord.statusLabel,
//                                         style: TextStyleCustom.bodySmall
//                                             .copyWith(
//                                                 color: PrimaryColor.primary_00),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: screenHeight * 0.01),
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: Divider(
//                                   color: NeutralColor.neutral_05,
//                                   thickness: 0.8,
//                                 ),
//                               ),
//                               SizedBox(height: screenHeight * 0.01),
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/icons/home/calendar.svg',
//                                         width: screenWidth * 0.06,
//                                         height: screenHeight * 0.03,
//                                       ),
//                                       SizedBox(width: screenWidth * 0.03),
//                                       Text(
//                                         generalRecord.conclusionTime,
//                                         style: TextStyleCustom.bodySmall
//                                             .copyWith(
//                                                 color: PrimaryColor.primary_10),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(height: screenHeight * 0.015),
//                                   Row(
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/icons/home/hospital.svg',
//                                         width: screenWidth * 0.06,
//                                         height: screenHeight * 0.03,
//                                       ),
//                                       SizedBox(width: screenWidth * 0.03),
//                                       Text(
//                                         generalRecord.medicalFacility,
//                                         style: TextStyleCustom.bodySmall
//                                             .copyWith(
//                                                 color: PrimaryColor.primary_10),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(height: screenHeight * 0.015),
//                                   Row(
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/icons/home/doctor.svg',
//                                         width: screenWidth * 0.06,
//                                         height: screenHeight * 0.03,
//                                       ),
//                                       SizedBox(width: screenWidth * 0.03),
//                                       Container(
//                                         constraints: BoxConstraints(
//                                             maxWidth: screenWidth * 0.7),
//                                         child: Text(
//                                           generalRecord.doctorName,
//                                           style: TextStyleCustom.bodySmall
//                                               .copyWith(
//                                                   color:
//                                                       PrimaryColor.primary_10),
//                                           overflow: TextOverflow.clip,
//                                           softWrap: true,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: screenHeight * 0.02),
//                               CustomButton(
//                                 type: ButtonType.standard,
//                                 state: ButtonState.fill1,
//                                 text: 'Xem chi tiết',
//                                 width: double.infinity,
//                                 height: screenHeight * 0.06,
//                                 onPressed: () {},
//                               )
//                             ],
//                           ),
//                         );
//                       });
//                 }
//                 )
//           ],
//         ),
//       ),
//     );
//   }
// }
