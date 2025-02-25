import 'package:flutter/material.dart';
import 'package:mediaid/design_system/color/primary_color.dart';

class AllergyHistory extends StatefulWidget{
  const AllergyHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AllergyHistoryState();
  }
}

class _AllergyHistoryState extends State<AllergyHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(

      )
    );
  }

}