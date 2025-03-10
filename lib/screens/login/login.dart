import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaid/routes.dart';
import '../../design_system/button/button.dart';
import '../../design_system/color/primary_color.dart';
import '../../design_system/color/status_color.dart';
import '../../design_system/input_field/text_input.dart';
import '../../design_system/textstyle/textstyle.dart';
import '../home/home.dart';
import 'package:mediaid/screens/registration/registration.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogIn> {
  bool isButtonActive = false;

  bool isPersonalIDLogInValid = true;
  String? personalIDLogInError;

  // Mật khẩu
  bool isPasswordObscuredLogIn = true;
  bool isPasswordValidLogIn = true;
  String? passwordLogInError;

  // FocusNodes để theo dõi khi rời khỏi ô nhập liệu
  late FocusNode personalIDLogInFocusNode;
  late FocusNode passwordLogInFocusNode;

  // Controller
  final TextEditingController personalIdentifierLogInController =
      TextEditingController();
  final TextEditingController patientPasswordLogInController =
      TextEditingController();

  void _showSuccessDialog(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Tự động đóng popup sau 2 giây và chuyển trang
        Future.delayed(Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/home');
          }
        });
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          backgroundColor: PrimaryColor.primary_00,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/images/registration/success_dialog.jpg',
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Đăng nhập thành công!',
                  style: TextStyleCustom.bodyLarge
                      .copyWith(color: StatusColor.successFull),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    personalIDLogInFocusNode = FocusNode();
    passwordLogInFocusNode = FocusNode();

    personalIdentifierLogInController.addListener(_validateForm);
    patientPasswordLogInController.addListener(_validateForm);

    // isPersonalIDLogInValid = _validatePersonalIDLogIn(personalIdentifierLogInController.text);
    // isPasswordValidLogIn = _validatePasswordLogIn(patientPasswordLogInController.text);
  }

  @override
  void dispose() {
    personalIdentifierLogInController.dispose();
    patientPasswordLogInController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isPersonalIDLogInValid =
          _validatePersonalIDLogIn(personalIdentifierLogInController.text);
      isPasswordValidLogIn =
          _validatePasswordLogIn(patientPasswordLogInController.text);
      isButtonActive = isPersonalIDLogInValid && isPasswordValidLogIn;
    });
  }

  // Hàm check CCCD / CMT
  bool _validatePersonalIDLogIn(String personalIDLogIn) {
    if (personalIDLogIn.isNotEmpty && personalIDLogIn.length < 12) {
      personalIDLogInError = 'Số CCCD/CMT phải có 12 số';
      return false;
    }
    personalIDLogInError = null;
    return true;
  }

  // Hàm check mật khẩu
  bool _validatePasswordLogIn(String passwordLogIn) {
    // Biểu thức chính quy kiểm tra các yêu cầu mật khẩu
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$',
    );

    if (passwordLogIn.isNotEmpty && !passwordRegExp.hasMatch(passwordLogIn)) {
      passwordLogInError = passwordLogInError =
          'Mật khẩu phải có:\n- Ít nhất 8 ký tự và tối đa 20 ký tự\n- Chứa ít nhất 1 chữ cái viết hoa, 1 chữ cái viết thường\n- Chứa ít nhất 1 số và 1 ký tự đặc biệt';
      return false;
    }

    passwordLogInError = null;
    return true;
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
            SizedBox(height: screenHeight * 0.04),
            Center(
              child: Image.asset(
                'assets/images/log_in/doctor_log_in.jpg',
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Text(
              'Đăng nhập hồ sơ điện tử',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              children: [
                CustomTextInput(
                  label: 'Số CCCD/CMT',
                  isRequired: true,
                  type: TextFieldType.text,
                  state: isPersonalIDLogInValid
                      ? TextFieldState.defaultState
                      : TextFieldState.error,
                  hintText: 'Điền số CCCD/CMT',
                  controller: personalIdentifierLogInController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  errorMessage: personalIDLogInError,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextInput(
                  label: 'Mật khẩu',
                  isRequired: true,
                  type: TextFieldType.textIconRight,
                  state: isPasswordValidLogIn
                      ? TextFieldState.defaultState
                      : TextFieldState.error,
                  hintText: 'Điền mật khẩu đúng yêu cầu',
                  obscureText: isPasswordObscuredLogIn,
                  icon: isPasswordObscuredLogIn
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onTap: () {
                    setState(() {
                      isPasswordObscuredLogIn = !isPasswordObscuredLogIn;
                    });
                  },
                  controller: patientPasswordLogInController,
                  keyboardType: TextInputType.multiline,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        r'[a-zA-Z0-9À-ỹ\s!@#$%^&*()_+\-=\[\]{};":\\|,.<>/?`~]')),
                    // Cho phép ký tự đặc biệt
                  ],
                  errorMessage: passwordLogInError,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomButton(
              type: ButtonType.standard,
              state: isButtonActive ? ButtonState.fill1 : ButtonState.disabled,
              text: "Tiếp tục",
              width: double.infinity,
              height: screenHeight * 0.06,
              onPressed: isButtonActive
                  ? () {
                      _showSuccessDialog;
                    }
                  : null,
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chưa có hồ sơ điện tử ?",
                  style: TextStyleCustom.bodySmall,
                ),
                CustomButton(
                  type: ButtonType.standard,
                  state: ButtonState.text,
                  text: "Đăng ký ngay",
                  width: screenWidth * 0.03,
                  height: screenHeight * 0.06,
                  onPressed: () {
                    Navigator.pushNamed(context, MediaidRoutes.registration);
                  },
                )
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
