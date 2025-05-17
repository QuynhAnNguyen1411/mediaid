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
import '../../api/register_w_loginAPI/registration_api.dart';
import '../../design_system/color/neutral_color.dart';
import '../../models/registrationModel/genderModel.dart';
import '../../models/registrationModel/nationModel.dart';
import '../../models/registrationModel/registrationForm.dart';
import '../../util/spacingStandards.dart';


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
  final TextEditingController nationPatientController = TextEditingController();
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
  bool isFamilyPersonalIDValid = true;
  String? familyPersonalIDError;
  bool isFamilyPhoneNumberValid = true;
  String? familyPhoneNumberError;

  // Mật khẩu
  bool isPasswordObscured = true;
  bool isPasswordValid = true;
  String? passwordError;

  //Dropdown
  late List<NationModel> _danTocList = [];
  late List<GenderModel> _gioiTinhList = [];

  int? _selectedDantocId;
  int? _selectedGioitinhId;

  // FocusNodes để theo dõi khi rời khỏi ô nhập liệu
  late FocusNode personalIDFocusNode;
  late FocusNode healthInsuranceFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode passwordFocusNode;

  late FocusNode familyPersonalIDFocusNode;
  late FocusNode familyPhoneNumberFocusNode;

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
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02),
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
            ));
      },
    );
  }

  void _showFailureDialog(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      barrierDismissible: false,
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
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02),
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
                      'Đăng ký không thành công!',
                      style: TextStyleCustom.bodyLarge
                          .copyWith(color: StatusColor.errorFull),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Hãy thử lại ngay',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context,
                            '/registration'); // Chuyển về màn hình đăng nhập
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              ),
            ));
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

  @override
  void initState() {
    super.initState();
    _fetchDropdownData();
    personalIDFocusNode = FocusNode();
    healthInsuranceFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    familyPersonalIDFocusNode = FocusNode();
    familyPhoneNumberFocusNode = FocusNode();
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

    patientFamilyNameController.addListener(_validateForm);
    patientRelationshipController.addListener(_validateForm);
    patientFamilyIdentifierController.addListener(_validateForm);
    patientFamilyPhoneNumberController.addListener(_validateForm);
  }

  @override
  void dispose() {
    personalIDFocusNode.dispose();
    healthInsuranceFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    familyPersonalIDFocusNode.dispose();
    familyPhoneNumberFocusNode.dispose();

    personalIdentifierController.dispose();
    healthInsuranceController.dispose();
    patientNameController.dispose();
    dobController.dispose();
    addressPatientController.dispose();
    phoneNumberController.dispose();
    patientPasswordController.dispose();

    patientFamilyNameController.dispose();
    patientRelationshipController.dispose();
    patientFamilyIdentifierController.dispose();
    patientFamilyPhoneNumberController.dispose();

    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isPersonalIDValid =
          _validatePersonalID(personalIdentifierController.text);
      isFamilyPersonalIDValid =
          _validateFamilyPersonalID(patientFamilyIdentifierController.text);
      isHealthInsuranceValid =
          _validateHealthInsurance(healthInsuranceController.text);
      isPhoneNumberValid = _validatePhoneNumber(phoneNumberController.text);
      isFamilyPhoneNumberValid =
          _validateFamilyPhoneNumber(patientFamilyPhoneNumberController.text);
      isPasswordValid = _validatePassword(patientPasswordController.text);
      isFormValid = isPersonalIDValid &&
          isHealthInsuranceValid &&
          isFamilyPersonalIDValid &&
          isPhoneNumberValid &&
          isFamilyPhoneNumberValid &&
          isPasswordValid &&
          patientNameController.text.trim().isNotEmpty &&
          dobController.text.trim().isNotEmpty &&
          _selectedGioitinhId != null &&
          addressPatientController.text.trim().isNotEmpty &&
          patientFamilyNameController.text.trim().isNotEmpty &&
          patientRelationshipController.text.trim().isNotEmpty &&
          patientFamilyIdentifierController.text.trim().isNotEmpty &&
          patientFamilyPhoneNumberController.text.trim().isNotEmpty;
    });
  }

  // Hàm check CCCD / CMT - Bệnh nhân
  bool _validatePersonalID(String personalID) {
    if (personalID.isEmpty || personalID.length == 12) {
      personalIDError = null;
      return true;
    }
    personalIDError = 'Số CCCD/CMT phải có 12 số';
    return false;
  }

// Hàm check CCCD / CMT - Người nhà bệnh nhân
  bool _validateFamilyPersonalID(String familyPersonalID) {
    if (familyPersonalID.isEmpty || familyPersonalID.length == 12) {
      familyPersonalIDError = null;
      return true;
    }
    familyPersonalIDError = 'Số CCCD/CMT phải có 12 số';
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

  // Hàm check số điện thoại - Bệnh nhân
  bool _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isNotEmpty && phoneNumber.length < 10) {
      phoneNumberError = 'Số điện thoại phải có 10 hoặc 11 số';
      return false;
    }
    phoneNumberError = null;
    return true;
  }

  // Hàm check số điện thoại - Người nhà bệnh nhân
  bool _validateFamilyPhoneNumber(String familyPhoneNumber) {
    if (familyPhoneNumber.isNotEmpty && familyPhoneNumber.length < 10) {
      familyPhoneNumberError = 'Số điện thoại phải có 10 hoặc 11 số';
      return false;
    }
    familyPhoneNumberError = null;
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

  Future<void> _fetchDropdownData() async {
    try {
      Map<String, List<Object>>? response =
          await RegistrationApi.getStaticDataForRegistration();

      if (response != null) {
        setState(() {
          _danTocList = (response['danToc'] as List<NationModel>).toList();
          _gioiTinhList = (response['gioiTinh'] as List<GenderModel>).toList();
        });

        print("✅ Đã cập nhật danh sách Dân tộc: $_danTocList");
        print("✅ Đã cập nhật danh sách Giới tính: $_gioiTinhList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Tiếp tục"
  Future<void> _submitForm() async {
    // Tạo đối tượng RegistrationForm từ dữ liệu nhập vào
    String bhyt;
    if (selectedRadio != null) {
      bhyt = selectedRadio ?? "Không dùng bảo hiểm y tế";
    } else {
      bhyt = healthInsuranceController.text;
    }
    RegistrationForm form = RegistrationForm(
      personalIdentifier: personalIdentifierController.text,
      healthInsurance: bhyt,
      patientName: patientNameController.text,
      addressPatient: addressPatientController.text,
      phoneNumber: phoneNumberController.text,
      emailPatient: emailPatientController.text,
      dob: dobController.text,
      sexPatient: _selectedGioitinhId ?? 1,
      nationPatient: _selectedDantocId ?? 1,
      patientPassword: patientPasswordController.text,
      patientFamilyName: patientFamilyNameController.text,
      patientRelationship: patientRelationshipController.text,
      patientFamilyIdentifier: patientFamilyIdentifierController.text,
      patientFamilyPhoneNumber: patientFamilyPhoneNumberController.text,
    );

    // Gửi form đến API
    try {
      print(form.toJson());
      await RegistrationApi.submitForm(form);
      bool success = true;
      if (success) {
        _showSuccessDialog(context);
      } else {
        _showFailureDialog(context);
      }
    } catch (e) {
      // Hiển thị thông báo lỗi nếu gửi thất bại
      _showFailureDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: SpacingUtil.spacingWidth16(context),
                vertical: SpacingUtil.spacingHeight24(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo Hospital K
                    Image.asset(
                      'assets/logo/national_cancer_hospital_logo.jpg',
                      width: LogoSizeUtil.medium(context),
                    ),

                    // Button display language
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SpacingUtil.spacingWidth16(context),
                          vertical: SpacingUtil.spacingHeight12(context)),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
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
                            width: SpacingUtil.spacingWidth32(context),
                            // width: screenWidth * 0.08,
                            // height: screenHeight * 0.04,
                          ),
                          SizedBox(width: SpacingUtil.spacingWidth12(context)),
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
                SizedBox(height: SpacingUtil.spacingHeight32(context)),
                // Text: Đăng ký hồ sơ điện tử
                Text(
                  'Đăng ký hồ sơ điện tử',
                  style: TextStyleCustom.heading_1a
                      .copyWith(color: PrimaryColor.primary_10),
                ),
                SizedBox(height: SpacingUtil.spacingHeight24(context)),
                // Thông tin bệnh nhân
                // Text: Thông tin bệnh nhân
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin bệnh nhân',
                      style: TextStyleCustom.heading_2a
                          .copyWith(color: NeutralColor.neutral_08),
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight24(context)),
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
                    SizedBox(height: SpacingUtil.spacingHeight12(context)),
                    // Radio buttons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRadioButton(
                          isSelected: selectedRadio == 'Không dùng bảo hiểm y tế',
                          isDisabled: false,
                          label: "Không dùng bảo hiểm y tế",
                          onChanged: (isSelected) {
                            setState(() {
                              selectedRadio =
                              isSelected ? 'Không dùng bảo hiểm y tế' : '';
                              healthInsuranceController.clear();
                              _validateForm();
                            });
                          },
                        ),
                        SizedBox(height: SpacingUtil.spacingHeight12(context)),
                        CustomRadioButton(
                          isSelected: selectedRadio == 'Miễn',
                          isDisabled: false,
                          label: "Miễn",
                          onChanged: (isSelected) {
                            setState(() {
                              selectedRadio = isSelected ? 'Miễn' : '';
                              healthInsuranceController.clear();
                              _validateForm();
                            });
                          },
                        ),
                        SizedBox(height: SpacingUtil.spacingHeight12(context)),
                        CustomRadioButton(
                          isSelected: selectedRadio == 'Khác',
                          isDisabled: false,
                          label: "Khác",
                          onChanged: (isSelected) {
                            setState(() {
                              selectedRadio = isSelected ? 'Khác' : '';
                              _validateForm();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      label: 'Mật khẩu',
                      isRequired: true,
                      type: TextFieldType.textIconRight,
                      state: isPasswordValid
                          ? TextFieldState.defaultState
                          : TextFieldState.error,
                      hintText: 'Điền mật khẩu đúng yêu cầu',
                      obscureText: isPasswordObscured,
                      iconTextInput: isPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onTapIconTextInput: () {
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    // Ngày sinh + Giới tính
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                iconTextInput: Icons.calendar_month,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: SpacingUtil.spacingWidth12(context)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Giới tính',
                                      style: TextStyleCustom.heading_3b
                                          .copyWith(color: PrimaryColor.primary_10)),
                                  SizedBox(width: SpacingUtil.spacingWidth8(context)),
                                  Text(
                                    '*',
                                    style: TextStyle(color: StatusColor.errorFull),
                                  ),
                                ],
                              ),
                              SizedBox(height: SpacingUtil.spacingHeight12(context)),
                              DropdownButtonFormField<int>(
                                value: _selectedGioitinhId,
                                hint: Text('Chọn giới tính',
                                    style: TextStyleCustom.bodySmall.copyWith(
                                        color: NeutralColor.neutral_06)),
                                isExpanded: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: SpacingUtil.spacingWidth12(context), vertical: SpacingUtil.spacingHeight16(context)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: NeutralColor.neutral_04,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: NeutralColor.neutral_04,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                dropdownColor: PrimaryColor.primary_00,
                                items: _gioiTinhList.map((gioiTinh) {
                                  return DropdownMenuItem<int>(
                                      value: gioiTinh.genderID,
                                      child: Text(
                                        gioiTinh.genderName,
                                        style: TextStyleCustom.bodySmall.copyWith(
                                            color: PrimaryColor.primary_10),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGioitinhId = value;
                                  });
                                  _validateForm();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dân tộc',
                            style: TextStyleCustom.heading_3b
                                .copyWith(color: PrimaryColor.primary_10)),
                        SizedBox(height: SpacingUtil.spacingHeight12(context)),
                        // Dropdown Button
                        DropdownButtonFormField(
                          value: _selectedDantocId,
                          hint: Text(
                            'Chọn dân tộc',
                            style: TextStyleCustom.bodySmall.copyWith(
                              color: NeutralColor.neutral_06,
                            ),
                          ),
                          isExpanded: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: SpacingUtil.spacingWidth12(context), vertical: SpacingUtil.spacingHeight16(context)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: NeutralColor.neutral_04,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: NeutralColor.neutral_04,
                                width: 2,
                              ),
                            ),
                          ),
                          dropdownColor: PrimaryColor.primary_00,
                          items: _danTocList.map((danToc) {
                            return DropdownMenuItem<int>(
                              value: danToc.nationID,
                              child: Text(
                                danToc.nationName,
                                style: TextStyleCustom.bodySmall
                                    .copyWith(color: PrimaryColor.primary_10),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDantocId = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
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
                SizedBox(height: SpacingUtil.spacingHeight32(context)),
                // Thông tin người nhà bệnh nhân
                Column(
                  children: [
                    Text(
                      'Thông tin người nhà bệnh nhân / người giám hộ',
                      style: TextStyleCustom.heading_2a
                          .copyWith(color: NeutralColor.neutral_08),
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight24(context)),
                    CustomTextInput(
                      label: 'Họ tên người nhà bệnh nhân',
                      isRequired: true,
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      label: 'Mối quan hệ với bệnh nhân',
                      isRequired: true,
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
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      label: 'Số CCCD / CMT',
                      isRequired: true,
                      type: TextFieldType.text,
                      state: isFamilyPersonalIDValid
                          ? TextFieldState.defaultState
                          : TextFieldState.error,
                      hintText: 'Điền số CCCD/CMT người nhà bệnh nhân',
                      controller: patientFamilyIdentifierController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                      ],
                      errorMessage: familyPersonalIDError,
                    ),
                    SizedBox(height: SpacingUtil.spacingHeight16(context)),
                    CustomTextInput(
                      label: 'Số điện thoại',
                      isRequired: true,
                      type: TextFieldType.text,
                      state: isFamilyPhoneNumberValid
                          ? TextFieldState.defaultState
                          : TextFieldState.error,
                      hintText: 'Điền số điện thoại người nhà bệnh nhân',
                      controller: patientFamilyPhoneNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      errorMessage: familyPhoneNumberError,
                    ),
                  ],
                ),
                SizedBox(height: SpacingUtil.spacingHeight24(context)),
                CustomButton(
                  type: ButtonType.standard,
                  state: isFormValid ? ButtonState.fill1 : ButtonState.disabled,
                  text: "Tiếp tục",
                  width: double.infinity,
                  height: SpacingUtil.spacingHeight56(context),
                  onPressed: isFormValid
                      ? () {
                    _submitForm();
                  }
                      : null,
                ),
                SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                      width: SpacingUtil.spacingWidth8(context),
                      height: SpacingUtil.spacingHeight8(context),
                      onPressed: () {
                        Navigator.pushNamed(context, MediaidRoutes.logIn);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        )

    );
  }
}