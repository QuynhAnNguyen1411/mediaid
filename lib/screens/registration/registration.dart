import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/color/status_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import 'package:mediaid/design_system/selection/radio_button.dart';
import 'package:mediaid/routes.dart';
import 'package:mediaid/screens/login/login.dart';

import '../../api/register_w_login/registration_api.dart';
import '../../design_system/color/neutral_color.dart';
import '../../models/registration/gender.dart';
import '../../models/registration/nation.dart';
import '../electronicHealthRecord/personalInformation/patientHistory/patientHistory_Common.dart';

final formatter = DateFormat.yMd();

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegistrationState();
  }
}

class _RegistrationState extends State<Registration> {
  // Controller bệnh nhân
  final TextEditingController personalIdentifierController =
      TextEditingController();
  final TextEditingController healthInsuranceController =
      TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController addressPatientController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailPatientController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController sexPatientController = TextEditingController();
  final TextEditingController patientPasswordController =
      TextEditingController();

  // Controller người nhà bệnh nhân
  final TextEditingController patientFamilyNameController =
      TextEditingController();
  final TextEditingController patientRelationshipController =
      TextEditingController();
  final TextEditingController patientFamilyIdentifierController =
      TextEditingController();
  final TextEditingController patientFamilyPhoneNumberController =
      TextEditingController();

  DateTime? _selectedDate;
  String? selectedRadio;
  bool isFormValid = false;
  bool isHealthInsuranceValid = true;
  String? healthInsuranceError;
  bool isPersonalIDValid = true;
  String? personalIDError;
  bool isPhoneNumberValid = true;
  String? phoneNumberError;

  // Mật khẩu
  bool isPasswordObscured = true;
  bool isPasswordValid = true;
  String? passwordError;

  //Dropdown
  String? _selectedGender;
  List<Gender> genders = [];

  List<Nation> nations = [];
  String? _selectedNation;

  // FocusNodes để theo dõi khi rời khỏi ô nhập liệu
  late FocusNode personalIDFocusNode;
  late FocusNode healthInsuranceFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode passwordFocusNode;

  // Hàm hiển thị sau khi đăng ký thành công
  void _showSuccessDialog(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      barrierDismissible: false,
      // Không cho phép đóng popup bằng cách click bên ngoài
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          backgroundColor: PrimaryColor.primary_00,
          elevation: 5,
          child: SingleChildScrollView(
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
                    'Đăng ký thành công!',
                    style: TextStyleCustom.bodyLarge
                        .copyWith(color: StatusColor.successFull),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    'Hãy đăng nhập ngay.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, '/logIn'); // Chuyển về màn hình đăng nhập
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: PrimaryColor.primary_05,
            colorScheme: ColorScheme.light(
              primary: PrimaryColor.primary_05, // Màu tiêu đề và ngày được chọn
              onPrimary: PrimaryColor.primary_00, // Màu chữ trên nền primary
              onSurface: PrimaryColor.primary_10, // Màu chữ mặc định
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  // Tải dữ liệu dân tộc
  Future<void> _loadEthnicities() async {
    List<Nation> nationList = await getNation();
    setState(() {
      nations = nationList; // Cập nhật danh sách dân tộc
    });
  }

  // Tải dữ liệu dân tộc
  Future<void> _loadGender() async {
    List<Gender> genderList = await getGender(); // Lấy dữ liệu giới tính
    setState(() {
      genders = genderList; // Cập nhật danh sách giới tính
    });
  }

  @override
  void initState() {
    super.initState();

    personalIDFocusNode = FocusNode();
    healthInsuranceFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    personalIdentifierController.addListener(_validateForm);
    healthInsuranceController.addListener(() {
      setState(() {
        if (healthInsuranceController.text.isNotEmpty) {
          selectedRadio = null;
        }
        _validateForm();
      });
    });

    patientNameController.addListener(_validateForm);
    dobController.addListener(_validateForm);
    addressPatientController.addListener(_validateForm);
    phoneNumberController.addListener(_validateForm);
    patientPasswordController.addListener(_validateForm);

    _loadEthnicities();
    _loadGender();
  }

  @override
  void dispose() {
    personalIDFocusNode.dispose();
    healthInsuranceFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    passwordFocusNode.dispose();

    personalIdentifierController.dispose();
    healthInsuranceController.dispose();
    patientNameController.dispose();
    dobController.dispose();
    addressPatientController.dispose();
    phoneNumberController.dispose();
    patientPasswordController.dispose();

    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isPersonalIDValid =
          _validatePersonalID(personalIdentifierController.text);
      isHealthInsuranceValid =
          _validateHealthInsurance(healthInsuranceController.text);
      isPhoneNumberValid = _validatePhoneNumber(phoneNumberController.text);
      isPasswordValid = _validatePassword(patientPasswordController.text);
      isFormValid = isPersonalIDValid &&
          isHealthInsuranceValid &&
          patientNameController.text.trim().isNotEmpty &&
          dobController.text.trim().isNotEmpty &&
          addressPatientController.text.trim().isNotEmpty &&
          phoneNumberController.text.trim().isNotEmpty &&
          isPasswordValid;
    });
  }

  // Hàm check CCCD / CMT
  bool _validatePersonalID(String personalID) {
    if (personalID.isEmpty || personalID.length == 12) {
      personalIDError = null;
      return true;
    }
    personalIDError = 'Số CCCD/CMT phải có 12 số';
    return false;
  }

  // Hàm check số thẻ BHYT
  bool _validateHealthInsurance(String healthInsurance) {
    if (healthInsurance.isNotEmpty && healthInsurance.length < 15) {
      healthInsuranceError = 'Số thẻ BHYT phải đủ 15 ký tự';
      return false;
    }
    healthInsuranceError = null;
    return true;
  }

  // Hàm check số điện thoại
  bool _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isNotEmpty && phoneNumber.length < 10) {
      phoneNumberError = 'Số điện thoại phải có 10 hoặc 11 số';
      return false;
    }
    phoneNumberError = null;
    return true;
  }

// Hàm check mật khẩu
  bool _validatePassword(String password) {
    // Biểu thức chính quy kiểm tra các yêu cầu mật khẩu
    final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$',
    );

    if (password.isNotEmpty && !passwordRegExp.hasMatch(password)) {
      passwordError = passwordError =
          'Mật khẩu phải có:\n- Ít nhất 8 ký tự và tối đa 20 ký tự\n- Chứa ít nhất 1 chữ cái viết hoa, 1 chữ cái viết thường\n- Chứa ít nhất 1 số và 1 ký tự đặc biệt';
      return false;
    }

    passwordError = null;
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
              // Text: Đăng ký hồ sơ điện tử
              Text(
                'Đăng ký hồ sơ điện tử',
                style: TextStyleCustom.heading_2a
                    .copyWith(color: PrimaryColor.primary_10),
              ),
              SizedBox(height: screenHeight * 0.015),
              // Thông tin bệnh nhân
              // Text: Thông tin bệnh nhân
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thông tin bệnh nhân',
                    style: TextStyleCustom.heading_3a
                        .copyWith(color: PrimaryColor.primary_10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // CCCD / CMT
                  CustomTextInput(
                    label: 'Số CCCD/CMT',
                    isRequired: true,
                    type: TextFieldType.text,
                    state: isPersonalIDValid
                        ? TextFieldState.defaultState
                        : TextFieldState.error,
                    hintText: 'Điền số CCCD/CMT',
                    controller: personalIdentifierController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                    ],
                    errorMessage: personalIDError,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Trường số thẻ BHYT (chỉ bắt buộc nếu không chọn radio)
                  CustomTextInput(
                    label: 'Số thẻ BHYT',
                    isRequired: selectedRadio == null,
                    type: TextFieldType.text,
                    state: isHealthInsuranceValid
                        ? TextFieldState.defaultState
                        : TextFieldState.error,
                    hintText: 'Điền số thẻ BHYT',
                    controller: healthInsuranceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(15),
                    ],
                    errorMessage: healthInsuranceError,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  // Radio buttons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRadioButton(
                        isSelected: selectedRadio == 'option1',
                        isDisabled: false,
                        label: "Không dùng bảo hiểm y tế",
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = 'option1';
                            healthInsuranceController.clear();
                            _validateForm();
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      CustomRadioButton(
                        isSelected: selectedRadio == 'option2',
                        isDisabled: false,
                        label: "Miễn",
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = 'option2';
                            healthInsuranceController.clear();
                            _validateForm();
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      CustomRadioButton(
                        isSelected: selectedRadio == 'option3',
                        isDisabled: false,
                        label: "Khác",
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = 'option3';
                            _validateForm();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Tên bệnh nhân
                  CustomTextInput(
                    label: 'Họ tên bệnh nhân',
                    isRequired: true,
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền họ tên bệnh nhân đầy đủ',
                    controller: patientNameController,
                    keyboardType: TextInputType.multiline,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextInput(
                    label: 'Mật khẩu',
                    isRequired: true,
                    type: TextFieldType.textIconRight,
                    state: isPasswordValid
                        ? TextFieldState.defaultState
                        : TextFieldState.error,
                    hintText: 'Điền mật khẩu đúng yêu cầu',
                    obscureText: isPasswordObscured,
                    icon: isPasswordObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onTap: () {
                      setState(() {
                        isPasswordObscured = !isPasswordObscured;
                      });
                    },
                    controller: patientPasswordController,
                    keyboardType: TextInputType.multiline,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[a-zA-Z0-9À-ỹ\s!@#$%^&*()_+\-=\[\]{};":\\|,.<>/?`~]')),
                      // Cho phép ký tự đặc biệt
                    ],
                    errorMessage: passwordError,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Ngày sinh + Dân tộc
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _presentDatePicker,
                          // Gọi DatePicker khi nhấn vào ô nhập
                          child: AbsorbPointer(
                            // Ngăn người dùng nhập tay
                            child: CustomTextInput(
                              type: TextFieldType.textIconRight,
                              state: TextFieldState.defaultState,
                              label: 'Ngày sinh',
                              isRequired: true,
                              hintText: "Chọn ngày sinh",
                              controller: dobController,
                              icon: Icons.calendar_month,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Giới tính',
                                style: TextStyleCustom.heading_3b
                                    .copyWith(color: PrimaryColor.primary_10)),
                            SizedBox(height: screenHeight * 0.005),
                            DropdownButtonFormField<String>(
                              value: _selectedGender,
                              hint: Text('Chọn giới tính',
                                  style: TextStyleCustom.bodySmall.copyWith(
                                      color: NeutralColor.neutral_06)),
                              isExpanded: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                    vertical: screenHeight * 0.018),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: NeutralColor.neutral_04,
                                    width: screenWidth * 0.004,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: NeutralColor.neutral_04,
                                    width: screenWidth * 0.004,
                                  ),
                                ),
                              ),
                              dropdownColor: PrimaryColor.primary_00,
                              items: genders.map((gender) {
                                return DropdownMenuItem<String>(
                                    value: gender.genderID.toString(),
                                    child: Text(
                                      gender.genderName,
                                      style: TextStyleCustom.bodySmall.copyWith(
                                          color: PrimaryColor.primary_10),
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dân tộc',
                            style: TextStyleCustom.heading_3b
                                .copyWith(color: PrimaryColor.primary_10)),
                        SizedBox(height: screenHeight * 0.005),
                        // Dropdown Button
                        DropdownButtonFormField(
                          value: _selectedNation,
                          hint: Text(
                            'Chọn dân tộc',
                            style: TextStyleCustom.bodySmall.copyWith(
                              color: NeutralColor.neutral_06,
                            ),
                          ),
                          isExpanded: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: NeutralColor.neutral_04,
                                width: screenWidth * 0.004,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: NeutralColor.neutral_04,
                                width: screenWidth * 0.004,
                              ),
                            ),
                          ),
                          dropdownColor: PrimaryColor.primary_00,
                          items: nations.map((nation) {
                            return DropdownMenuItem<String>(
                              value: nation.nationID.toString(),
                              child: Text(
                                nation.nationName,
                                style: TextStyleCustom.bodySmall
                                    .copyWith(color: PrimaryColor.primary_10),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedNation = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Địa chỉ cư trú
                  CustomTextInput(
                    label: 'Địa chỉ cư trú',
                    isRequired: true,
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền địa chỉ cư trú',
                    controller: addressPatientController,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Số điện thoại
                  CustomTextInput(
                    label: 'Số điện thoại',
                    isRequired: true,
                    type: TextFieldType.text,
                    state: isPhoneNumberValid
                        ? TextFieldState.defaultState
                        : TextFieldState.error,
                    hintText: 'Điền đầy đủ số điện thoại',
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    errorMessage: phoneNumberError,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Email
                  CustomTextInput(
                    label: 'Email',
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền đầy đủ email',
                    controller: emailPatientController,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              // Thông tin người nhà bệnh nhân
              Column(
                children: [
                  Text(
                    'Thông tin người nhà bệnh nhân / người giám hộ',
                    style: TextStyleCustom.heading_3a
                        .copyWith(color: PrimaryColor.primary_10),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextInput(
                    label: 'Họ tên người nhà bệnh nhân / người giám hộ',
                    isRequired: false,
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền họ tên người nhà bệnh nhân / người giám hộ',
                    controller: patientFamilyNameController,
                    keyboardType: TextInputType.multiline,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextInput(
                    label: 'Mối quan hệ với bệnh nhân',
                    isRequired: false,
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền mối quan hệ với bệnh nhân',
                    controller: patientRelationshipController,
                    keyboardType: TextInputType.multiline,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextInput(
                    label: 'Số CCCD / CMT',
                    isRequired: false,
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền số CCCD/CMT người nhà bệnh nhân',
                    controller: patientFamilyIdentifierController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                    ],
                    errorMessage: personalIDError,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CustomTextInput(
                    label: 'Số điện thoại',
                    isRequired: false,
                    type: TextFieldType.text,
                    state: TextFieldState.defaultState,
                    hintText: 'Điền số điện thoại người nhà bệnh nhân',
                    controller: patientFamilyPhoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    errorMessage: phoneNumberError,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomButton(
                type: ButtonType.standard,
                state: isFormValid ? ButtonState.fill1 : ButtonState.disabled,
                text: "Tiếp tục",
                width: double.infinity,
                height: screenHeight * 0.06,
                onPressed: isFormValid
                    ? () {
                        _showSuccessDialog(context);
                      }
                    : null,
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đã có hồ sơ điện tử ?",
                    style: TextStyleCustom.bodySmall,
                  ),
                  CustomButton(
                    type: ButtonType.standard,
                    state: ButtonState.text,
                    text: "Đăng nhập ngay",
                    width: screenWidth * 0.03,
                    height: screenHeight * 0.06,
                    onPressed: () {
                      Navigator.pushNamed(context, MediaidRoutes.logIn);
                    },
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ));
  }
}
