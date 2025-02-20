import 'package:flutter/material.dart';
import 'package:mediaid/screens/registration/PatientInformation.dart';
import 'package:mediaid/screens/registration/basicMedicalInformation/MedicalHistory.dart';
import 'package:mediaid/screens/splash/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bệnh viện K',
      home: MedicalHistory(),
    );
  }
}