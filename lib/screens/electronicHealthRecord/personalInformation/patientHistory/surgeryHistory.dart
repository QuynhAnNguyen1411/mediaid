import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediaid/models/electronicHealthRecord/personalInformation/surgeryHistory.dart';

import '../../../../api/electronicHealthRecord/patientHistory_api.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/neutral_color.dart';
import '../../../../design_system/color/primary_color.dart';
import '../../../../design_system/color/status_color.dart';
import '../../../../design_system/input_field/text_input.dart';
import '../../../../design_system/textstyle/textstyle.dart';
import '../../../../models/electronicHealthRecord/personalInformation/level.dart';
import '../../../../models/electronicHealthRecord/personalInformation/reasonSurgery.dart';

class SurgeryHistory extends StatefulWidget {
  const SurgeryHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SurgeryHistoryState();
  }
}

class _SurgeryHistoryState extends State<SurgeryHistory>
    with SingleTickerProviderStateMixin {
  bool isExpandedSurgeryHistory = false;

  // Controller Tiểu sử phẫu thuật
  final TextEditingController nameSurgeryController = TextEditingController();
  final TextEditingController reasonSurgeryController = TextEditingController();
  final TextEditingController surgeryLevelController = TextEditingController();
  final TextEditingController timeSurgeryController = TextEditingController();
  final TextEditingController surgicalHospitalController =
      TextEditingController();
  final TextEditingController complicationSurgeryController =
      TextEditingController();
  final TextEditingController noteSurgeryController = TextEditingController();

  // Danh sách chứa các form nhập liệu
  List<Widget> surgeryHistoryForms = [];

  //Dropdown
  late List<Level> mucDoList = [];
  int? _selectedMucdoId;

  //Dropdown
  late List<ReasonSurgery> lyDoPhauThuatList = [];
  int? _selectedLydophauthuatId;

  void _resetFormSurgeryHistory() {
    nameSurgeryController.clear();
    reasonSurgeryController.clear();
    timeSurgeryController.clear();
    surgicalHospitalController.clear();
    complicationSurgeryController.clear();
    noteSurgeryController.clear();
    setState(() {
      _selectedMucdoId = null;
    });
  }

  Future<void> _fetchDropdownDataSurgeryHistory() async {
    try {
      Map<String, List<Object>>? response =
      await PatientHistoryApi.getStaticDataForPatientHistory();

      if (response != null) {
        print("a");
        setState(() {
          mucDoList = (response['mucDo'] as List<Level>).toList();
          lyDoPhauThuatList = (response['lyDoPhauThuat'] as List<ReasonSurgery>).toList();
        });

        print("✅ Đã cập nhật danh sách Mức độ: $mucDoList");
        print("✅ Đã cập nhật danh sách Lý do phẫu thuật: $lyDoPhauThuatList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }
  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin" - Tiểu sử phẫu thuật
  Future<void> _submitFormSurgeryHistory() async {
    SurgeryHistoryForm form = SurgeryHistoryForm(
        nameSurgery: nameSurgeryController.text,
        reasonSurgery: _selectedLydophauthuatId ?? 1,
        surgeryLevel: _selectedMucdoId ?? 1,
        timeSurgery: timeSurgeryController.text,
        surgicalHospital: surgicalHospitalController.text,
        complicationSurgery: complicationSurgeryController.text,
        noteSurgery: noteSurgeryController.text,
    );

    // Gửi form đến API
    try {
      print(form.toJson());
      await PatientHistoryApi.submitFormSurgeryHistory(form);
      print('Form đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi form: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    _fetchDropdownDataSurgeryHistory();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: PrimaryColor.primary_00,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title:
                  Text('Tiểu sử phẫu thuật', style: TextStyleCustom.heading_3a),
              trailing: CustomButton(
                type: ButtonType.iconOnly,
                state: ButtonState.text,
                width: screenWidth * 0.1,
                height: screenHeight * 0.05,
                icon: Icons.add_circle_outline_rounded,
                onPressed: () => _showSurgeryHistory(context),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.001),
              child: Text(
                'Ghi chú: Bỏ qua nếu không có',
                style: TextStyleCustom.caption,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Visibility(
              visible: surgeryHistoryForms.isNotEmpty,
              child: Scrollbar(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: PrimaryColor.primary_10, width: 1),
                    // Đường viền của container
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: screenHeight * 0.6,
                  // Giới hạn chiều cao của container
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: surgeryHistoryForms.map((form) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: Stack(
                            children: [
                              form,
                              Positioned(
                                top: screenHeight * 0.015,
                                right: screenWidth * 0.02,
                                child: IconButton(
                                  icon: Icon(Icons.close,
                                      color: StatusColor.errorFull),
                                  onPressed: () {
                                    setState(() {
                                      // Xóa form khỏi danh sách
                                      surgeryHistoryForms.remove(form);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSurgeryHistory(BuildContext context){
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
                      label: 'Tên loại phẫu thuật',
                      hintText: 'Điền loại phẫu thuật',
                      controller: nameSurgeryController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lý do phẫu thuật',
                                style: TextStyleCustom.heading_3b.copyWith(color: PrimaryColor.primary_10),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Lý do phẫu thuật chính", style: TextStyleCustom.heading_3c),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "• Điều trị bệnh lý:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật để loại bỏ hoặc điều trị các vấn đề sức khỏe nghiêm trọng như khối u, viêm nhiễm, hoặc các bệnh lý nội tạng. \n Ví dụ: Phẫu thuật cắt bỏ khối u, mổ cắt ruột thừa.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Cấp cứu:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật được thực hiện ngay lập tức để cứu sống bệnh nhân hoặc giảm thiểu thiệt hại từ vết thương hoặc tai nạn. \n Ví dụ: Phẫu thuật khẩn cấp sau tai nạn, vết thương chấn thương.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Chỉnh hình:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật chỉnh hình giúp phục hồi chức năng cơ xương khớp hoặc sửa chữa các tổn thương về xương. \n Ví dụ: Mổ thay khớp háng, nắn chỉnh xương gãy.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Phẫu thuật thẩm mỹ:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật này nhằm mục đích cải thiện ngoại hình, thẩm mỹ của cơ thể hoặc khuôn mặt. \n Ví dụ: Nâng mũi, phẫu thuật cắt mí mắt.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Phẫu thuật nội soi:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật sử dụng dụng cụ chuyên dụng để can thiệp vào cơ thể qua các vết mổ nhỏ, ít đau đớn, hồi phục nhanh. \n Ví dụ: Mổ nội soi cắt túi mật, nội soi dạ dày.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Cải thiện chức năng:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật để thay thế hoặc phục hồi chức năng các cơ quan trong cơ thể, chẳng hạn như ghép tạng. \n Ví dụ: Phẫu thuật ghép thận, thay van tim.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Điều trị nhiễm trùng:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật này nhằm làm sạch và loại bỏ nhiễm trùng, mủ hoặc các chất có hại trong cơ thể. \n Ví dụ: Phẫu thuật dẫn lưu áp xe, phẫu thuật loại bỏ mô nhiễm trùng.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Chẩn đoán:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật nhằm mục đích thu thập mẫu mô hoặc kiểm tra tình trạng bệnh lý bên trong cơ thể. \n Ví dụ: Phẫu thuật sinh thiết, phẫu thuật mở bụng để kiểm tra các bệnh lý ẩn.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Điều trị bệnh lý thần kinh:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật điều trị các bệnh lý liên quan đến hệ thần kinh, như u não hoặc bệnh lý cột sống. \n Ví dụ: Phẫu thuật chèn đĩa đệm nhân tạo.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Phẫu thuật giảm đau:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Mục đích của phẫu thuật này là giảm đau mãn tính không thể điều trị bằng phương pháp khác. \n Ví dụ: Phẫu thuật chèn đĩa đệm nhân tạo.",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Phẫu thuật giảm cân (Phẫu thuật bariatric):",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật này giúp giảm cân cho những người béo phì, cải thiện sức khỏe và giảm nguy cơ mắc các bệnh lý liên quan đến thừa cân. \n Ví dụ: Phẫu thuật thu nhỏ dạ dày (bypass dạ dày).",
                                                style: TextStyleCustom.bodySmall
                                                    .copyWith(color: NeutralColor.neutral_06),
                                              ),
                                              SizedBox(height: screenHeight * 0.02),
                                              Text(
                                                "• Phẫu thuật điều trị ung thư:",
                                                style: TextStyleCustom.bodyLarge
                                                    .copyWith(color: PrimaryColor.primary_10),
                                              ),
                                              Text(
                                                "Phẫu thuật nhằm loại bỏ hoặc giảm kích thước khối u ung thư để ngừng sự phát triển của tế bào ung thư \n Ví dụ: Phẫu thuật cắt bỏ khối u ung thư, mổ hạch lympho.",
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
                                            child: Text("Đóng", style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_05)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/electronicHealthRecord/info.svg",
                                  color: StatusColor.errorLighter,
                                  width: screenWidth * 0.06,
                                  height: screenHeight * 0.03,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          DropdownButtonFormField<int>(
                            value: _selectedLydophauthuatId,
                            hint: Text(
                              'Chọn lý do phẫu thuật',
                              style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                            ),
                            isExpanded: true,
                            decoration: InputDecoration(
                              // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.018),
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
                            items: lyDoPhauThuatList.map((phuongPhapDieuTri) {
                              return DropdownMenuItem<int>(
                                value: phuongPhapDieuTri.reasonSurgeryID,
                                child: Text(
                                  phuongPhapDieuTri.reasonSurgeryName,
                                  style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLydophauthuatId = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mức độ',
                                    style: TextStyleCustom.heading_3b.copyWith(color: PrimaryColor.primary_10),
                                  ),
                                  GestureDetector( // Thêm GestureDetector để xử lý sự kiện onTap
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Mức độ phẫu thuật", style: TextStyleCustom.heading_3c),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  // Nhẹ
                                                  Text(
                                                    "• Phẫu thuật nhẹ:",
                                                    style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                                  ),
                                                  Text(
                                                    "Các phẫu thuật ít xâm lấn, thời gian hồi phục nhanh, ví dụ như cắt polyp, mổ u nang nhỏ, phẫu thuật nội soi.",
                                                    style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.015),
                                                  // Vừa
                                                  Text(
                                                    "• Phẫu thuật vừa:",
                                                    style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                                  ),
                                                  Text(
                                                    "Phẫu thuật có xâm lấn lớn hơn, thời gian hồi phục lâu hơn, ví dụ như thay khớp gối, phẫu thuật cắt ruột thừa, cắt bỏ u xơ tử cung.",
                                                    style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                                  ),
                                                  SizedBox(height: screenHeight * 0.015),
                                                  // Nặng
                                                  Text(
                                                    "• Phẫu thuật nặng:",
                                                    style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10),
                                                  ),
                                                  Text(
                                                    "Các phẫu thuật đe dọa tính mạng, yêu cầu can thiệp phức tạp và thời gian hồi phục dài, ví dụ như phẫu thuật tim mạch, cắt bỏ ung thư, ghép tạng.",
                                                    style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Đóng dialog
                                                },
                                                child: Text("Đóng", style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_05)),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/electronicHealthRecord/info.svg",
                                      color: StatusColor.errorLighter,
                                      width: screenWidth * 0.06,
                                      height: screenHeight * 0.03,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              DropdownButtonFormField<int>(
                                value: _selectedMucdoId,
                                hint: Text(
                                  'Chọn mức độ',
                                  style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_06),
                                ),
                                isExpanded: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.03, vertical: screenHeight * 0.018),
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
                                items: mucDoList.map((mucDo) {
                                  return DropdownMenuItem<int>(
                                    value: mucDo.levelID,
                                    child: Text(
                                      mucDo.levelName,
                                      style: TextStyleCustom.bodySmall.copyWith(color: PrimaryColor.primary_10),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedMucdoId = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(
                            child: CustomTextInput(
                              label: 'Thời gian mổ',
                              type: TextFieldType.text,
                              state: TextFieldState.defaultState,
                              hintText: 'Điền thời gian',
                              controller: timeSurgeryController,
                              keyboardType: TextInputType.multiline,
                            )),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Bệnh viện phẫu thuật',
                      hintText: 'Điền bệnh viện thực hiện phẫu thuật',
                      controller: surgicalHospitalController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Biến chứng',
                      hintText: 'Điền biến chứng sau phẫu thuật (nếu có)',
                      controller: complicationSurgeryController,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextInput(
                      type: TextFieldType.text,
                      state: TextFieldState.defaultState,
                      label: 'Ghi chú',
                      hintText: 'Điền ghi chú',
                      controller: noteSurgeryController,
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
                              _resetFormSurgeryHistory();
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
