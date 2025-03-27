import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/electronicHealthRecord/personalInformation/patientHistory/patientHistory_Common.dart';
import 'package:mediaid/screens/registration/registration.dart';
import 'components/home/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Hive
  await Hive.initFlutter();

  // Mở box lưu trữ
  await Hive.openBox('loginBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bệnh viện K',
      initialRoute: MediaidRoutes.registration,
      onGenerateRoute: MediaidRoutes.generateRoute,
    );
  }
}
