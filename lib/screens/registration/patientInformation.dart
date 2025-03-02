import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:mediaid/design_system/button/button.dart';
import 'package:mediaid/design_system/color/primary_color.dart';
import 'package:mediaid/design_system/input_field/text_input.dart';
import 'package:mediaid/design_system/textstyle/textstyle.dart';
import 'package:mediaid/design_system/selection/radio_button.dart';
import 'package:mediaid/screens/electronicHealthRecord/basicMedicalInformation/medicalHistory.dart';

import '../../api/register_w_login/registration_api.dart';
import '../../design_system/color/neutral_color.dart';
import '../../models/gender.dart';
import '../../models/nation.dart';

final formatter = DateFormat.yMd();

class PatientInformation extends StatefulWidget {
  const PatientInformation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PatientInformationState();
  }
}

class _PatientInformationState extends State<PatientInformation> {
  // Controller bệnh nhân
  final TextEditingController personalIdentifierController = TextEditingController();
  final TextEditingController healthInsuranceController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController addressPatientController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailPatientController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController sexPatientController = TextEditingController();

  // Controller người nhà bệnh nhân
  final TextEditingController patientFamilyNameController = TextEditingController();
  final TextEditingController patientRelationshipController = TextEditingController();
  final TextEditingController patientFamilyIdentifierController = TextEditingController();
  final TextEditingController patientFamilyPhoneNumberController = TextEditingController();


  DateTime? _selectedDate;
  String? selectedRadio;
  bool isFormValid = false;
  bool isHealthInsuranceValid = true;
  String? healthInsuranceError;
  bool isPersonalIDValid = true;
  String? personalIDError;
  bool isPhoneNumberValid = true;
  String? phoneNumberError;

  //Dropdown
  String? _selectedGender;
  List<Gender> genders = [];

  List<Nation> nations = [];
  String? _selectedNation;

  // FocusNodes để theo dõi khi rời khỏi ô nhập liệu
  // Thay vì final, chọn late để tránh tạo null ban đầu
  late FocusNode personalIDFocusNode;
  late FocusNode healthInsuranceFocusNode;
  late FocusNode phoneNumberFocusNode;

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

    _loadEthnicities();
    _loadGender();
  }

  @override
  void dispose() {
    personalIDFocusNode.dispose();
    healthInsuranceFocusNode.dispose();
    phoneNumberFocusNode.dispose();

    personalIdentifierController.dispose();
    healthInsuranceController.dispose();
    patientNameController.dispose();
    dobController.dispose();
    addressPatientController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isPersonalIDValid =
          _validatePersonalID(personalIdentifierController.text);
      isHealthInsuranceValid =
          _validateHealthInsurance(healthInsuranceController.text);
      isPhoneNumberValid = _validatePhoneNumber(phoneNumberController.text);

      isFormValid = isPersonalIDValid &&
          isHealthInsuranceValid &&
          patientNameController.text.trim().isNotEmpty &&
          dobController.text.trim().isNotEmpty &&
          addressPatientController.text.trim().isNotEmpty &&
          phoneNumberController.text.trim().isNotEmpty;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      height: 65,
                      width: 85,
                    ),

                    // Button display language
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
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
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 12),
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
              const SizedBox(height: 30),
              // Text: Đăng ký hồ sơ điện tử
              Text(
                'Đăng ký hồ sơ điện tử',
                style: TextStyleCustom.heading_2a
                    .copyWith(color: PrimaryColor.primary_10),
              ),
              const SizedBox(height: 16),
              // Text: Thông tin bệnh nhân
              Text(
                'Thông tin bệnh nhân',
                style: TextStyleCustom.heading_3a
                    .copyWith(color: PrimaryColor.primary_10),
              ),
              const SizedBox(height: 16),
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
                errorMessage:
                    personalIDError, // Hiển thị lỗi khi nhập chưa đủ 12 số
              ),

              const SizedBox(height: 16),
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

              const SizedBox(height: 12),

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
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
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

              const SizedBox(height: 16),
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
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                ],
              ),
              const SizedBox(height: 16),
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
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Giới tính',
                            style: TextStyleCustom.heading_3b
                                .copyWith(color: PrimaryColor.primary_10)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          hint: Text('Chọn giới tính', style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06)),
                          isExpanded: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
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
                                width: 1.5,
                              ),
                            ),
                          ),
                          dropdownColor: PrimaryColor.primary_00,
                          items: genders.map((gender) {
                            return DropdownMenuItem<String>(
                                value: gender.gender,
                                child: Text(
                                  gender.gender,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: PrimaryColor.primary_10),
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
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dân tộc',
                        style: TextStyleCustom.heading_3b
                            .copyWith(color: PrimaryColor.primary_10)),
                    const SizedBox(height: 8),
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                            width: 1.5,
                          ),
                        ),
                      ),
                      dropdownColor: PrimaryColor.primary_00,
                      items: nations.map((nation) {
                        return DropdownMenuItem<String>(
                          value: nation.id,
                          child: Text(
                            nation.name,
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              // Email
              CustomTextInput(
                label: 'Email',
                type: TextFieldType.text,
                state: TextFieldState.defaultState,
                hintText: 'Điền đầy đủ email',
                controller: emailPatientController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Text(
                'Thông tin người nhà bệnh nhân / người giám hộ',
                style: TextStyleCustom.heading_3a
                    .copyWith(color: PrimaryColor.primary_10),
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                label: 'Họ tên người nhà bệnh nhân / người giám hộ',
                isRequired: false,
                type: TextFieldType.text,
                state: TextFieldState.defaultState,
                hintText: 'Điền họ tên người nhà bệnh nhân / người giám hộ',
                controller: patientFamilyNameController,
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                label: 'Mối quan hệ với bệnh nhân',
                isRequired: false,
                type: TextFieldType.text,
                state: TextFieldState.defaultState,
                hintText: 'Điền mối quan hệ với bệnh nhân',
                controller: patientRelationshipController,
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                label: 'Số CCCD / CMT',
                isRequired: false,
                type: TextFieldType.text,
                state: TextFieldState.defaultState,
                hintText: 'Điền số CCCD/CMT người nhà bệnh nhân',
                controller: patientFamilyIdentifierController,
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                label: 'Số điện thoại',
                isRequired: false,
                type: TextFieldType.text,
                state: TextFieldState.defaultState,
                hintText: 'Điền số điện thoại người nhà bệnh nhân',
                controller: patientFamilyPhoneNumberController,
                keyboardType: TextInputType.multiline,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ỹ\s]')),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                type: ButtonType.standard,
                state: isFormValid ? ButtonState.fill1 : ButtonState.disabled,
                text: "Tiếp tục",
                width: double.infinity,
                height: 50,
                onPressed: isFormValid
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedicalHistory()),
                        );
                      }
                    : null,
              ),
              const SizedBox(height: 12),
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
                    width: 100,
                    height: 50,
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
