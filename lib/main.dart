import 'package:flutter/material.dart';
import 'package:mediaid/screens/registration/patientInformation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bệnh viện K',
      home: PatientInformation(),
    );
  }
}