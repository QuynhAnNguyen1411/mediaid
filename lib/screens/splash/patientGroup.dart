// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mediaid/routes.dart';
// import 'package:mediaid/screens/registration/registration.dart';
// import 'package:mediaid/screens/splash/navigationSurvey.dart';
//
// import '../../components/registration/patientGroupItem.dart';
// import '../../design_system/button/button.dart';
// import '../../design_system/color/primary_color.dart';
// import '../../design_system/textstyle/textstyle.dart';
//
// class PatientGroup extends StatefulWidget {
//   const PatientGroup({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _PatientGroupState();
//   }
// }
//
// class _PatientGroupState extends State<PatientGroup> {
//   int? _selectedPatientGroupIndex;
//
//   bool get isEnabled => _selectedPatientGroupIndex != null;
//
//   void _selectPatientGroup(int index) {
//     setState(() {
//       if (_selectedPatientGroupIndex == index) {
//         _selectedPatientGroupIndex = null;
//       } else {
//         _selectedPatientGroupIndex = index;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: PrimaryColor.primary_00,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SafeArea(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Logo Hospital K
//                   Image.asset(
//                     'assets/logo/national_cancer_hospital_logo.jpg',
//                     height: screenHeight * 0.07,
//                     width: screenWidth * 0.2,
//                   ),
//
//                   // Button display language
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.03,
//                         vertical: screenHeight * 0.005),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xFFCCDEE7),
//                           Color(0xFFCCDEE7),
//                           Color(0xFF015C89),
//                         ],
//                         stops: [0.0, 0.12, 0.88],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         // VN flag
//                         Image.asset(
//                           'assets/images/registration/vietnam_flag.jpg',
//                           width: screenWidth * 0.08,
//                           height: screenHeight * 0.04,
//                         ),
//                         SizedBox(width: screenWidth * 0.03),
//                         // Text Vietnam
//                         Text(
//                           'Vietnam',
//                           style: TextStyleCustom.heading_3b
//                               .copyWith(color: PrimaryColor.primary_00),
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.04),
//             Text(
//               'Đối tượng khám bệnh',
//               style: TextStyleCustom.heading_2a
//                   .copyWith(color: PrimaryColor.primary_10),
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Center(
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: PatientGroupItem(
//                           isSelected: _selectedPatientGroupIndex == 0,
//                           isDisabled: false,
//                           label: 'Người trên 14 tuổi',
//                           icon: SvgPicture.asset(
//                             'assets/icons/registration/people_over_14_years_old.svg',
//                             height: screenHeight * 0.08,
//                             width: screenWidth * 0.15,
//                           ),
//                           onChanged: (isSelected) {
//                             _selectPatientGroup(0);
//                           },
//                         ),
//                       ),
//                       SizedBox(width: screenWidth * 0.03),
//                       Expanded(
//                         child: PatientGroupItem(
//                           isSelected: _selectedPatientGroupIndex == 1,
//                           isDisabled: false,
//                           label: 'Người dưới 14 tuổi',
//                           icon: SvgPicture.asset(
//                             'assets/icons/registration/people_under_14_years_old.svg',
//                             height: screenHeight * 0.08,
//                             width: screenWidth * 0.15,
//                           ),
//                           onChanged: (isSelected) {
//                             _selectPatientGroup(1);
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: PatientGroupItem(
//                           isSelected: _selectedPatientGroupIndex == 2,
//                           isDisabled: false,
//                           label: 'Người cao tuổi',
//                           icon: SvgPicture.asset(
//                             'assets/icons/registration/elderly_people.svg',
//                             height: screenHeight * 0.08,
//                             width: screenWidth * 0.15,
//                           ),
//                           onChanged: (isSelected) {
//                             _selectPatientGroup(2);
//                           },
//                         ),
//                       ),
//                       SizedBox(width: screenWidth * 0.03),
//                       Expanded(
//                         child: PatientGroupItem(
//                           isSelected: _selectedPatientGroupIndex == 3,
//                           isDisabled: false,
//                           label: 'Người khuyết tật',
//                           icon: SvgPicture.asset(
//                             'assets/icons/registration/disabled_people.svg',
//                             height: screenHeight * 0.08,
//                             width: screenWidth * 0.15,
//                           ),
//                           onChanged: (isSelected) {
//                             _selectPatientGroup(3);
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: EdgeInsets.only(bottom: screenHeight * 0.025),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: CustomButton(
//                       type: ButtonType.standard,
//                       state: ButtonState.outline,
//                       text: 'Quay lại',
//                       width: double.infinity,
//                       height: screenHeight * 0.06,
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   SizedBox(width: screenWidth * 0.02),
//                   Expanded(
//                     child: CustomButton(
//                       type: ButtonType.standard,
//                       state:
//                           isEnabled ? ButtonState.fill1 : ButtonState.disabled,
//                       text: 'Tiếp tục',
//                       width: double.infinity,
//                       height: screenHeight * 0.06,
//                       onPressed: () {
//                         Navigator.pushNamed(context, MediaidRoutes.registration);
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
