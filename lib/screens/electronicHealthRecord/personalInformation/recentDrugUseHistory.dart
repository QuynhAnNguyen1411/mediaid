import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mediaid/api/electronicHealthRecord/drugHistory_api.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/usageStatus.dart';

import '../../../design_system/button/button.dart';
import '../../../design_system/color/neutral_color.dart';
import '../../../design_system/color/primary_color.dart';
import '../../../design_system/color/status_color.dart';
import '../../../design_system/input_field/text_input.dart';
import '../../../design_system/textstyle/textstyle.dart';
import '../../../routes.dart';

class DrugHistory extends StatefulWidget {
  const DrugHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DrugHistoryState();
  }
}

class _DrugHistoryState extends State<DrugHistory> {
  bool isExpandedPrescriptionDrugs = false;
  bool isExpandedNonPrescriptionDrugs = false;

  bool isChecked = false;
  bool isDisabled = false;

  // Controller Thuốc kê đơn
  final TextEditingController namePDController = TextEditingController();
  final TextEditingController usageStatusPDController = TextEditingController();
  final TextEditingController startPDController = TextEditingController();
  final TextEditingController endPDController = TextEditingController();
  final TextEditingController notePDController = TextEditingController();

  // Controller Thuốc không kê đơn / Thực phẩm chức năng
  final TextEditingController typeNPDController = TextEditingController();
  final TextEditingController nameNPDController = TextEditingController();
  final TextEditingController usageStatusNPDController =
      TextEditingController();
  final TextEditingController startNPDController = TextEditingController();
  final TextEditingController endNPDController = TextEditingController();
  final TextEditingController noteNPDController = TextEditingController();

  DateTime? startPDDate;
  DateTime? endPDDate;
  DateTime? startNPDDate;
  DateTime? endNPDDate;

  // Danh sách chứa các form nhập liệu
  List<Widget> prescriptionDrugsForms = [];
  List<Widget> nonPrescriptionDrugsForms = [];

  // // dropdown
  // Future<void> _fetchDropdownDataDrugHistory() async {
  //   try {
  //     Map<String, List<Object>>? response =
  //     await DrugHistoryApi.getStaticDataForDrugHistory();
  //
  //     if (response != null) {
  //       print("a");
  //       setState(() {
  //         tinhTrangSuDungList = (response['mucDo'] as List<UsageStatus>).toList();
  //         phuongPhapDieuTriList =
  //             (response['phuongPhapDieuTri'] as List<TreatmentMethod>).toList();
  //       });
  //
  //       print("✅ Đã cập nhật danh sách Mức độ: $mucDoList");
  //       print(
  //           "✅ Đã cập nhật danh sách Phương pháp điều trị: $phuongPhapDieuTriList");
  //     } else {
  //       print("❌ Lỗi API: ${response}");
  //     }
  //   } catch (e) {
  //     print("❌ Lỗi khi gọi API: $e");
  //   }
  // }

  void _resetFormPrescriptionDrugs() {
    namePDController.clear();
    startPDController.clear();
    endPDController.clear();
    notePDController.clear();
    usageStatusPDController.clear();
  }

  void _resetFormNonPrescriptionDrugs() {
    typeNPDController.clear();
    nameNPDController.clear();
    usageStatusNPDController.clear();
    startNPDController.clear();
    endNPDController.clear();
    noteNPDController.clear();
  }

  void _presentDatePickerForStart({required String field}) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: PrimaryColor.primary_05,
            colorScheme: ColorScheme.light(
              primary: PrimaryColor.primary_05,
              onPrimary: PrimaryColor.primary_00,
              onSurface: PrimaryColor.primary_10,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (field == 'startPD') {
          if (endPDDate != null && pickedDate.isAfter(endPDDate!)) {
            // Nếu ngày bắt đầu lớn hơn ngày kết thúc, cảnh báo người dùng
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Ngày bắt đầu không thể lớn hơn ngày kết thúc")),
            );
          } else {
            startPDDate = pickedDate;
            startPDController.text =
                DateFormat('dd/MM/yyyy').format(pickedDate);
          }
        } else if (field == 'startNPD') {
          if (endNPDDate != null && pickedDate.isAfter(endNPDDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Ngày bắt đầu không thể lớn hơn ngày kết thúc")),
            );
          } else {
            startNPDDate = pickedDate;
            startNPDController.text =
                DateFormat('dd/MM/yyyy').format(pickedDate);
          }
        }
      });
    }
  }

  void _presentDatePickerForEnd({required String field}) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: PrimaryColor.primary_05,
            colorScheme: ColorScheme.light(
              primary: PrimaryColor.primary_05,
              onPrimary: PrimaryColor.primary_00,
              onSurface: PrimaryColor.primary_10,
            ),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (field == 'endPD') {
          if (startPDDate != null && pickedDate.isBefore(startPDDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Ngày kết thúc không thể nhỏ hơn ngày bắt đầu")),
            );
          } else {
            endPDDate = pickedDate;
            endPDController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
          }
        } else if (field == 'endNPD') {
          if (startNPDDate != null && pickedDate.isBefore(startNPDDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Ngày kết thúc không thể nhỏ hơn ngày bắt đầu")),
            );
          } else {
            endNPDDate = pickedDate;
            endNPDController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
          }
        }
      });
    }
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
            // Text: Thông tin bệnh nhân
            Text(
              'Lịch sử sử dụng thuốc gần đây',
              style: TextStyleCustom.heading_3a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            SizedBox(height: screenHeight * 0.02),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Thuốc kê đơn', style: TextStyleCustom.heading_3a),
              trailing: CustomButton(
                type: ButtonType.iconOnly,
                state: ButtonState.text,
                width: screenWidth * 0.1,
                height: screenHeight * 0.05,
                icon: Icons.add_circle_outline_rounded,
                onPressed: () => _showPrescriptionDrugs(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.001),
              child: Text(
                'Ghi chú: Bỏ qua nếu không có',
                style: TextStyleCustom.caption,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Thuốc không kê đơn / Thực phẩm chức năng',
                  style: TextStyleCustom.heading_3a),
              trailing: CustomButton(
                type: ButtonType.iconOnly,
                state: ButtonState.text,
                width: screenWidth * 0.1,
                height: screenHeight * 0.05,
                icon: Icons.add_circle_outline_rounded,
                onPressed: () => _showNonPrescriptionDrugs(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.001),
              // Căn lề ngang với nội dung
              child: Text(
                'Ghi chú: Bỏ qua nếu không có',
                style: TextStyleCustom.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _showPrescriptionDrugs(BuildContext context){
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
              backgroundColor: PrimaryColor.primary_00,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenHeight * 0.08, screenWidth * 0.04, screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Tên loại thuốc',
                        iconLabel: SvgPicture.asset(
                          "assets/icons/electronicHealthRecord/info.svg",
                          color: StatusColor.errorLighter,
                          width: screenWidth * 0.06,
                          height: screenHeight * 0.03,
                        ),
                        onTapIconLabel: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: PrimaryColor.primary_00,
                                title: Text("Thuốc kê đơn có khả năng gây u cục",
                                    style: TextStyleCustom.heading_3c),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "• Thuốc thay thế hormone (HRT):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Tăng nguy cơ ung thư vú, tử cung, buồng trứng khi sử dụng lâu dài. \n Ví dụ: Estrogen, progesterone.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc điều trị ung thư:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Ví dụ: Chemotherapy (doxorubicin, cyclophosphamide) có thể gây ung thư thứ phát, Tamoxifen, aromatase inhibitors có thể làm tăng nguy cơ ung thư tử cung,...",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc corticoid (corticosteroids):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng lâu dài có thể gây tăng nguy cơ mắc bệnh tiểu đường, huyết áp cao, tổn thương thận và gan. \n Ví dụ: Prednisone, hydrocortisone.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc chống đông máu:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng lâu dài có thể gây loãng xương, tăng nguy cơ xuất huyết.\n Ví dụ: Warfarin, heparin.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc ức chế miễn dịch:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Dùng lâu dài có thể làm tăng nguy cơ mắc các bệnh ung thư do ức chế hệ miễn dịch. \n Ví dụ: Azathioprine, methotrexate, cyclosporine.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc điều trị tuyến giáp:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng lâu dài có thể làm gia tăng nguy cơ u cục hoặc bệnh lý tuyến giáp. \n Ví dụ: Levothyroxine, methimazole.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc điều trị tiểu đường:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng insulin hoặc thuốc giảm đường huyết lâu dài có thể gây ra các tác dụng phụ về mạch máu, thận, và có thể tăng nguy cơ ung thư. \n Ví dụ: Insulin, metformin, sulfonylureas.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc kháng sinh lâu dài:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Một số kháng sinh có thể gây tổn thương gan, thận, và ảnh hưởng đến hệ vi khuẩn trong cơ thể. \n Ví dụ: Tetracycline, doxycycline.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc trị trầm cảm và rối loạn tâm lý:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Một số thuốc chống trầm cảm lâu dài có thể thay đổi hệ thống nội tiết tố và gây u cục hoặc tác động đến sức khỏe.\n Ví dụ: SSRIs (fluoxetine, sertraline), thuốc an thần (haloperidol, clozapine).",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc giảm đau opioid",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Dùng opioid lâu dài có thể gây suy yếu hệ miễn dịch, và một số nghiên cứu chỉ ra rằng opioid có thể làm tăng nguy cơ mắc ung thư.\n Ví dụ: Oxycodone, morphine, fentanyl.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc điều trị viêm khớp (DMARDs):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Các thuốc như methotrexate có thể làm suy yếu hệ miễn dịch và tăng nguy cơ mắc các bệnh ung thư. \n Ví dụ: Methotrexate, sulfasalazine.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc điều trị tăng huyết áp:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Một số thuốc hạ huyết áp có thể gây ra các vấn đề về thận và mạch máu. \n Ví dụ: ACE inhibitors (enalapril), beta-blockers (metoprolol), diuretics (furosemide).",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Đóng dialog
                                    },
                                    child: Text("Đóng",
                                        style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_05)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        hintText: 'Điền tên loại thuốc',
                        controller: namePDController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextInput(
                        label: 'Tình trạng sử dụng',
                        type: TextFieldType.textIconRight,
                        state: TextFieldState.defaultState,
                        hintText: 'Tình trạng sử dụng hiện tại',
                        controller: usageStatusPDController,
                        iconTextInput: Icons.arrow_drop_down_sharp,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _presentDatePickerForStart(field: 'startPD'),
                              child: AbsorbPointer(
                                // Ngăn người dùng nhập tay
                                child: CustomTextInput(
                                  type: TextFieldType.textIconRight,
                                  state: TextFieldState.defaultState,
                                  label: 'Bắt đầu',
                                  hintText: "Chọn thời gian",
                                  controller: startPDController,
                                  iconTextInput: Icons.calendar_month,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _presentDatePickerForEnd(field: 'endPD'),
                              child: AbsorbPointer(
                                child: CustomTextInput(
                                  type: TextFieldType.textIconRight,
                                  state: TextFieldState.defaultState,
                                  label: 'Kết thúc',
                                  hintText: "Chọn thời gian",
                                  controller: endPDController,
                                  iconTextInput: Icons.calendar_month,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Ghi chú',
                        hintText: 'Điền ghi chú',
                        controller: notePDController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: ButtonState.fill2,
                              text: 'Xóa thông tin',
                              width: double.infinity,
                              height: screenHeight * 0.06,
                              onPressed: () {
                                _resetFormPrescriptionDrugs();
                              },
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: ButtonState.fill1,
                              text: 'Lưu thông tin',
                              width: double.infinity,
                              height: screenHeight * 0.06,
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              )
          );
        }
    );
  }

  void _showNonPrescriptionDrugs(BuildContext context){
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
              backgroundColor: PrimaryColor.primary_00,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenHeight * 0.08, screenWidth * 0.04, screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextInput(
                        label: 'Loại sử dụng',
                        type: TextFieldType.textIconRight,
                        state: TextFieldState.defaultState,
                        hintText: 'Chọn loại sử dụng',
                        controller: typeNPDController,
                        iconTextInput: Icons.arrow_drop_down_sharp,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Tên sản phẩm',
                        iconLabel: SvgPicture.asset(
                          "assets/icons/electronicHealthRecord/info.svg",
                          color: StatusColor.errorLighter,
                          width: screenWidth * 0.06,
                          height: screenHeight * 0.03,
                        ),
                        onTapIconLabel: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: PrimaryColor.primary_00,
                                title: Text("Thuốc không kê đơn và thực phẩm chức năng có khả năng gây u cục",
                                    style: TextStyleCustom.heading_3c),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "• Thuốc giảm cân:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng lâu dài có thể gây u mỡ, ảnh hưởng đến các mô trong cơ thể.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Vitamin và khoáng chất (Vitamin D, Canxi):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Dùng quá liều có thể gây u cục, tích tụ canxi ở các mô mềm.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• NSAIDs (Ibuprofen, Aspirin):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng lâu dài có thể dẫn đến tổn thương gan, thận, gây u trong cơ thể.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Collagen bổ sung:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Dùng lâu dài có thể gây tích tụ protein trong mô, dẫn đến u cục.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thực phẩm chức năng sinh lý (Yohimbine, Maca root):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Thay đổi hormone, tăng nguy cơ u cục trong tuyến tiền liệt.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc trị đau khớp (Glucosamine, Chondroitin):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng lâu dài có thể ảnh hưởng đến khớp và các mô mềm, gây u.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thực phẩm chức năng thảo dược (Saw Palmetto, Echinacea):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Thay đổi hormone, gây u trong các cơ quan sinh dục.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Text(
                                        "• Thuốc nhuận tràng (Bisacodyl, Sennosides):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Sử dụng lâu dài có thể gây vấn đề tiêu hóa và tăng nguy cơ u cục.",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(color: NeutralColor.neutral_06),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Đóng dialog
                                    },
                                    child: Text("Đóng",
                                        style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_05)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        hintText: 'Điền tên loại thuốc / thực phẩm chức năng',
                        controller: nameNPDController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextInput(
                        label: 'Tình trạng sử dụng',
                        type: TextFieldType.textIconRight,
                        state: TextFieldState.defaultState,
                        hintText: 'Tình trạng sử dụng hiện tại',
                        controller: usageStatusNPDController,
                        iconTextInput: Icons.arrow_drop_down_sharp,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _presentDatePickerForStart(field: 'startNPD'),
                              child: AbsorbPointer(
                                // Ngăn người dùng nhập tay
                                child: CustomTextInput(
                                  type: TextFieldType.textIconRight,
                                  state: TextFieldState.defaultState,
                                  label: 'Bắt đầu',
                                  hintText: "Chọn thời gian",
                                  controller: startNPDController,
                                  iconTextInput: Icons.calendar_month,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _presentDatePickerForEnd(field: 'endNPD'),
                              child: AbsorbPointer(
                                child: CustomTextInput(
                                  type: TextFieldType.textIconRight,
                                  state: TextFieldState.defaultState,
                                  label: 'Kết thúc',
                                  hintText: "Chọn thời gian",
                                  controller: endNPDController,
                                  iconTextInput: Icons.calendar_month,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Ghi chú',
                        hintText: 'Điền ghi chú',
                        controller: noteNPDController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: ButtonState.fill2,
                              text: 'Xóa thông tin',
                              width: double.infinity,
                              height: screenHeight * 0.06,
                              onPressed: () {
                                _resetFormNonPrescriptionDrugs();
                              },
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: ButtonState.fill1,
                              text: 'Lưu thông tin',
                              width: double.infinity,
                              height: screenHeight * 0.06,
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              )
          );
        }
    );
  }


}
