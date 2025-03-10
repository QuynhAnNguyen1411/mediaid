import 'package:flutter/material.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/electronicHealthRecord/electronicHealthRecord.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/medicalRecord.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/medicalRecordList.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/patientHistory_Common.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/personalInformation.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/recentDrugUseHistory.dart';
import 'package:mediaid/screens/home/home.dart';
import 'package:mediaid/screens/login/login.dart';
import 'package:mediaid/screens/registration/registration.dart';
import 'package:mediaid/screens/splash/medicalFacility.dart';
import 'package:mediaid/screens/splash/navigationSurvey.dart';
import 'package:mediaid/screens/splash/patientGroup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bệnh viện K',
      initialRoute: MediaidRoutes.registration,
      onGenerateRoute: MediaidRoutes.generateRoute,
    );
  }
}