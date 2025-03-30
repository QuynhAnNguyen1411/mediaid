import 'package:flutter/material.dart';
import 'package:mediaid/components/home/bottom_nav_bar.dart';
import 'package:mediaid/screens/electronicHealthRecord/electronicHealthRecord.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/medicalRecord.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/medicalRecordList.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/lifestyleSurvey.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/allergyHistory.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/medicalHistory.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/patientHistory_Common.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/surgeryHistory.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/recentDrugUseHistory.dart';
import 'package:mediaid/screens/home/home.dart';
import 'package:mediaid/screens/login/login.dart';
import 'package:mediaid/screens/registration/registration.dart';
import 'package:mediaid/screens/setExaminationNumber/maleBody.dart';
import 'package:mediaid/screens/splash/medicalFacility.dart';
import 'package:mediaid/screens/splash/navigationSurvey.dart';
import 'package:mediaid/screens/splash/patientGroup.dart';
import 'screens/splash/splash.dart';

class MediaidRoutes {
  static const String splash = '/splash';
  static const String patientGroup = '/patientGroup';
  static const String navigationSurvey = '/navigationSurvey';
  static const String medicalFacility = '/medicalFacility';
  static const String registration = '/registration';
  static const String logIn = '/logIn';
  static const String home = '/home';
  static const String electronicHealthRecord = '/electronicHealthRecord';
  static const String patientHistory = '/patientHistory';
  static const String allergyHistory = '/allergyHistory';
  static const String medicalHistory = '/medicalHistory';
  static const String surgeryHistory = '/surgeryHistory';
  static const String drugHistory = '/drugHistory';
  static const String lifestyleSurvey = '/lifestyleSurvey';
  static const String medicalRecord = '/medicalRecord';
  static const String medicalRecordList = '/medicalRecordList';
  static const String maleBody = '/maleBody';
  static const String bottomNavBar = '/bottomNavBar';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => Splash());
      case patientGroup:
        return MaterialPageRoute(builder: (_) => PatientGroup());
      case navigationSurvey:
        return MaterialPageRoute(builder: (_) => NavigationSurvey());
      case medicalFacility:
        return MaterialPageRoute(builder: (_) => MedicalFacility());
      case registration:
        return MaterialPageRoute(builder: (_) => Registration());
      case logIn:
        return MaterialPageRoute(builder: (_) => LogIn());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case electronicHealthRecord:
        return MaterialPageRoute(builder: (_) => ElectronicHealthRecord());
      case patientHistory:
        return MaterialPageRoute(builder: (_) => PatientHistory());
      case medicalHistory:
        return MaterialPageRoute(builder: (_) => MedicalHistory());
      case allergyHistory:
        return MaterialPageRoute(builder: (_) => AllergyHistory());
      case surgeryHistory:
        return MaterialPageRoute(builder: (_) => SurgeryHistory());
      case drugHistory:
        return MaterialPageRoute(builder: (_) => DrugHistory());
      case lifestyleSurvey:
        return MaterialPageRoute(builder: (_) => LifestyleSurvey());
      case medicalRecord:
        return MaterialPageRoute(builder: (_) => MedicalRecord());
      case medicalRecordList:
        return MaterialPageRoute(builder: (_) => MedicalRecordList());
      case maleBody:
        return MaterialPageRoute(builder: (_) => MaleBody());
      case bottomNavBar:
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      default:
        return MaterialPageRoute(builder: (_) => Splash());
    }
  }
}
