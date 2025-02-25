import 'package:flutter/material.dart';
import 'package:mediaid/screens/registration/patientInformation.dart';
import 'screens/registration/basicMedicalInformation/allergyHistory.dart';
import 'screens/registration/basicMedicalInformation/medicalHistory.dart';
import 'screens/splash/Splash.dart';

class MediaidRoutes {
  static const String splash = '/splash';
  static const String allergyHistory = '/allergy-history';
  static const String medicalHistory = '/medical-history';
  static const String patientInformation = '/patient-information';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => Splash());
      case allergyHistory:
        return MaterialPageRoute(builder: (_) => AllergyHistory());
      case medicalHistory:
        return MaterialPageRoute(builder: (_) => MedicalHistory());
      case patientInformation:
        return MaterialPageRoute(builder: (_) => PatientInformation());
      default:
        return MaterialPageRoute(builder: (_) => Splash());
    }
  }
}
