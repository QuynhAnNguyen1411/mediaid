import 'package:flutter/material.dart';

import '../../design_system/color/primary_color.dart';
import '../../design_system/textstyle/textstyle.dart';

class HumanBody extends StatefulWidget {
  const HumanBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HumanBodyState();
  }
}

class _HumanBodyState extends State<HumanBody> {
  final List<Map<String, dynamic>> markers = [
    {"x": 0.5, "y": 0.2, "label": "Đầu", "clinic": "Khoa Thần Kinh"},
    {"x": 0.5, "y": 0.4, "label": "Ngực", "clinic": "Khoa Tim Mạch"},
    {"x": 0.5, "y": 0.6, "label": "Bụng", "clinic": "Khoa Tiêu Hóa"},
    {"x": 0.5, "y": 0.8, "label": "Chân", "clinic": "Khoa Xương Khớp"},
  ];

  void _showClinicDialog(String part, String clinic) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Chọn bộ phận: $part"),
        content: Text("Phòng khám phù hợp: $clinic"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
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
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.005),
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
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Bạn đang gặp phải vấn đề gì vậy?',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            SizedBox(height: screenHeight * 0.03),
            Stack(
              children: [
                SizedBox(
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.6,
                  child: Image.asset(
                    "assets/images/setExaminationNumber/body_man_front.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                // Hiển thị các điểm đánh dấu
                ...markers.map((marker) => Positioned(
                  left: marker["x"] * MediaQuery.of(context).size.width,
                  top: marker["y"] * MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    onTap: () => _showClinicDialog(marker["label"], marker["clinic"]),
                    child: Icon(Icons.location_on, color: Colors.red, size: 30),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
