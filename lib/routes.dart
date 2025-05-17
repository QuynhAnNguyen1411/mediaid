import 'package:flutter/material.dart';
import 'package:mediaid/components/home/bottom_nav_bar.dart';
import 'package:mediaid/screens/electronicHealthRecord/electronicHealthRecord.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/detailedMedicalHistoryList.dart';
import 'package:mediaid/screens/electronicHealthRecord/medicalRecord/generalRecordList.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/drugHistory.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/lifestyleSurvey.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/patientHistory/allergyHistory.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/patientHistory/medicalHistory.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/patientHistory/patientHistory_Common.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/basicMedicalInformation/patientHistory/surgeryHistory.dart';
import 'package:mediaid/screens/home/home.dart';
import 'package:mediaid/screens/login/login.dart';
import 'package:mediaid/screens/registration/registration.dart';
import 'package:mediaid/screens/setExaminationNumber/clinicOrders.dart';
import 'package:mediaid/screens/setExaminationNumber/clinicSuggestion.dart';
import 'package:mediaid/screens/setExaminationNumber/maleBody.dart';
import 'package:mediaid/screens/splash/navigationSurvey.dart';
import 'screens/splash/splash.dart';

class MediaidRoutes {
  static const String splash = '/splash';
  static const String navigationSurvey = '/navigationSurvey';
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
  static const String generalMedicalRecord = '/medicalRecord';
  static const String medicalRecordList = '/medicalRecordList';
  static const String maleBody = '/maleBody';
  static const String bottomNavBar = '/bottomNavBar';
  static const String clinicSuggestions = '/clinicSuggestions';
  static const String clinicOrders = '/clinicOrders';
  static const String orderDetail = '/orderDetail';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => Splash());
      case navigationSurvey:
        return MaterialPageRoute(builder: (_) => NavigationSurvey());
      case registration:
        return MaterialPageRoute(builder: (_) => Registration());
      case logIn:
        return MaterialPageRoute(builder: (_) => LogIn());
      case home:
        print("router home");
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
      case generalMedicalRecord:
        return MaterialPageRoute(builder: (_) => GeneralRecordList());
      case medicalRecordList:
        return MaterialPageRoute(builder: (_) => DetailedRecordList(detailedRecordID: '',));
      case maleBody:
        return MaterialPageRoute(builder: (_) => MaleBody());
      case bottomNavBar:
        return MaterialPageRoute(builder: (_) => BottomNavBar());
      case clinicSuggestions:
        return MaterialPageRoute(builder: (_) => ClinicSuggestions());
      case clinicOrders:
        return MaterialPageRoute(builder: (_) => ClinicOrders());
      default:
        return MaterialPageRoute(builder: (_) => Splash());
    }
  }
}
