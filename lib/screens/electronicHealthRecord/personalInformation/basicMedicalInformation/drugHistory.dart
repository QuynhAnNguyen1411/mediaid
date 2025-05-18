import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../../../api/electronicHealthRecordAPI/basicMedicalInformationAPI/drugHistory_api.dart';
import '../../../../design_system/button/button.dart';
import '../../../../design_system/color/neutral_color.dart';
import '../../../../design_system/color/primary_color.dart';
import '../../../../design_system/color/status_color.dart';
import '../../../../design_system/input_field/text_input.dart';
import '../../../../design_system/textstyle/textstyle.dart';
import '../../../../models/electronicHealthRecordModel/personalInformation/drugsHistoryForm.dart';
import '../../../../models/electronicHealthRecordModel/personalInformation/typeOfDrugModel.dart';
import '../../../../models/electronicHealthRecordModel/personalInformation/usageStatusModel.dart';
import '../../../../util/spacingStandards.dart';

class DrugHistory extends StatefulWidget {
  const DrugHistory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DrugHistoryState();
  }
}

class _DrugHistoryState extends State<DrugHistory> {
  final TextEditingController drugsIDController = TextEditingController();
  final TextEditingController drugsTypeController = TextEditingController();
  final TextEditingController drugsNameController = TextEditingController();
  final TextEditingController usageStatusDrugsController =
      TextEditingController();
  final TextEditingController startDrugsController = TextEditingController();
  final TextEditingController endDrugsController = TextEditingController();
  final TextEditingController noteDrugsController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  List<Widget> drugsHistoryForms = [];

  //Dropdown
  late List<UsageStatusModel> tinhTrangSuDungList = [];
  late List<TypeOfDrugModel> loaiSanPhamList = [];
  int? _selectedTinhtrangsudungId;
  int? _selectedLoaisanphamId;

  Future<void> _fetchDropdownDataDrugHistory() async {
    try {
      Map<String, List<Object>>? response =
          await DrugHistoryApi.getStaticDataForDrugHistory();

      if (response != null) {
        setState(() {
          tinhTrangSuDungList =
              (response['tinhTrangSuDung'] as List<UsageStatusModel>).toList();
          loaiSanPhamList = (response['loaiSanPham'] as List<TypeOfDrugModel>).toList();
        });

        print(
            "✅ Đã cập nhật danh sách Tình trạng sử dụng: $tinhTrangSuDungList");
        print("✅ Đã cập nhật danh sách Lọai thuốc: $loaiSanPhamList");
      } else {
        print("❌ Lỗi API: ${response}");
      }
    } catch (e) {
      print("❌ Lỗi khi gọi API: $e");
    }
  }

  // Hàm gửi dữ liệu form khi nhấn nút "Lưu thông tin"
  Future<void> _submitFormPrescriptionDrugs() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');

    String? startFomartter;
    if(startDrugsController.text.isNotEmpty){
      DateTime? startParsed = DateTime.tryParse(startDrugsController.text);
      startFomartter = (startParsed!=null)?DateFormat('yyyy-MM-dd').format(startParsed) : null;
    }
    String? endFomartter;
    if(endDrugsController.text.isNotEmpty){
      DateTime? endParsed = DateTime.tryParse(endDrugsController.text);
      endFomartter = (endParsed!=null)?DateFormat('yyyy-MM-dd').format(endParsed) : null;
    }
    DrugsHistoryForm form = DrugsHistoryForm(
      drugsID: drugsIDController.text,
      accountID: accountID,
      drugsType: _selectedLoaisanphamId ?? 1,
      drugsName: drugsNameController.text,
      usageStatusDrugs: _selectedTinhtrangsudungId ?? 1,
      startDrugs: startFomartter,
      endDrugs: endFomartter,
      noteDrugs: noteDrugsController.text,
    );

    // Gửi form đến API
    try {
      print(form.toJson());
      await DrugHistoryApi.submitFormDrugsHistory(form);
      print('Form đã được gửi thành công.');
    } catch (e) {
      print('Có lỗi xảy ra khi gửi form: $e');
    }
    Navigator.pop(context);
  }

  void _resetFormDrugsHistory() {
    drugsIDController.clear();
    drugsTypeController.clear();
    drugsNameController.clear();
    usageStatusDrugsController.clear();
    startDrugsController.clear();
    endDrugsController.clear();
    noteDrugsController.clear();
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
          if (endDate != null && pickedDate.isAfter(endDate!)) {
            // Nếu ngày bắt đầu lớn hơn ngày kết thúc, cảnh báo người dùng
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Ngày bắt đầu không thể lớn hơn ngày kết thúc")),
            );
          } else {
            startDate = pickedDate;
            startDrugsController.text =
                DateFormat('yyyy-MM-dd').format(DateTime(pickedDate.year, pickedDate.month, pickedDate.day));
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
          if (startDate != null && pickedDate.isBefore(startDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text("Ngày kết thúc không thể nhỏ hơn ngày bắt đầu")),
            );
          } else {
            endDate = pickedDate;
            endDrugsController.text =
                DateFormat('yyyy-MM-dd').format(DateTime(pickedDate.year, pickedDate.month, pickedDate.day));
          }
        }
      });
    }
  }

  List<DrugsHistoryForm> drugsHistoryList = [];

  late Future<List<DrugsHistoryForm>> drugsHistoryListRender;

  // Load data form tóm tắt
  Future<List<DrugsHistoryForm>> _loadDrugsHistoryData() async {
    var box = await Hive.openBox('loginBox');
    String accountID = await box.get('accountID');
    List<DrugsHistoryForm> drugsHistory =
        await DrugHistoryApi.getDrugsHistoryData(accountID, 'TieuSuThuoc');
    setState(() {
      drugsHistoryList = drugsHistory;
    });
    return drugsHistory;
  }

  // Xóa form Thuoc ke don
  Future<void> _deleteMedicalHistoryForm(String? tieuSuThuocID, String type) async {
    if (tieuSuThuocID == null) {
      return;
    }
    // Gọi API để xóa mục theo ID
    await DrugHistoryApi.deleteDrugsHistoryForm(tieuSuThuocID, type);

    // Gọi lại hàm tải lại danh sách
    _loadDrugsHistoryData();
  }

  @override
  void initState() {
    super.initState();
    _fetchDropdownDataDrugHistory();
    drugsHistoryListRender = _loadDrugsHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final iconSize = IconSizeUtil();
    String option1 = 'Chỉnh sửa';
    String option2 = 'Xóa';
    return Scaffold(
        backgroundColor: PrimaryColor.primary_00,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.08),
          child: AppBar(
            title: Text(
              'Tiền sử thuốc',
              style: TextStyleCustom.heading_2a
                  .copyWith(color: PrimaryColor.primary_10),
            ),
            backgroundColor: PrimaryColor.primary_01,
            elevation: 4.0,
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: SpacingUtil.spacingWidth16(context),
                vertical: SpacingUtil.spacingHeight24(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<DrugsHistoryForm>>(
                    future: drugsHistoryListRender,
                    builder: (context, snapshot) {
                      // Kiểm tra trạng thái kết nối với Future
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Nếu dữ liệu đang được tải, hiển thị loading indicator
                        return Center(child: CircularProgressIndicator());
                      }
                      // Nếu có lỗi xảy ra khi tải dữ liệu
                      else if (snapshot.hasError) {
                        return Center(
                            child: Text('Có lỗi xảy ra: ${snapshot.error}'));
                      }
                      // Nếu không có dữ liệu (null)
                      else if (!snapshot.hasData) {
                        return Center(
                            child: Text('Không có dữ liệu bệnh nhân'));
                      }

                      // Dữ liệu đã được tải thành công
                      var drugsHistoryData = snapshot.data;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Thuốc sử dụng gần đây',
                                  style: TextStyleCustom.heading_3a),
                              trailing: CustomButton(
                                type: ButtonType.iconOnly,
                                state: ButtonState.text,
                                width: iconSize.mediumIcon(context),
                                height: iconSize.mediumIcon(context),
                                icon: Icons.add_circle_outline_rounded,
                                onPressed: () =>
                                    _showDrugsHistory(context, null),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: SpacingUtil.spacingHeight8(context)),
                              child: Text(
                                'Ghi chú: Bỏ qua nếu không có',
                                style: TextStyleCustom.bodySmall,
                              ),
                            ),
                            SizedBox(height: SpacingUtil.spacingHeight16(context)),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: drugsHistoryList.length,
                                itemBuilder: (context, index) {
                                  var drugsHistoryData =
                                      drugsHistoryList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: PrimaryColor.primary_00,
                                        border: Border.all(
                                          color: PrimaryColor.primary_10,
                                          width: 1.2,
                                        )),
                                    margin: EdgeInsets.symmetric(vertical: SpacingUtil.spacingHeight12(context)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: SpacingUtil.spacingWidth12(context), vertical: SpacingUtil.spacingHeight12(context)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(drugsHistoryData.drugsName, style: TextStyleCustom.bodyLarge.copyWith(color: PrimaryColor.primary_10)),
                                              SizedBox(width: SpacingUtil.spacingWidth12(context)),
                                              Row(
                                                children: [
                                                  Text(drugsHistoryData.startDrugs.toString(), style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_08)),
                                                  SizedBox(width: SpacingUtil.spacingWidth8(context)),
                                                  Text('-'),
                                                  SizedBox(width: SpacingUtil.spacingWidth8(context)),
                                                  Text(drugsHistoryData.endDrugs.toString(), style: TextStyleCustom.bodySmall.copyWith(color: NeutralColor.neutral_08)),
                                                ],
                                              )
                                            ],
                                          ),
                                          PopupMenuTheme(
                                            data: PopupMenuThemeData(
                                              color: PrimaryColor.primary_00,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: PopupMenuButton<String>(
                                              icon: Icon(Icons.more_vert),
                                              onSelected: (String newValue) {
                                                if (newValue == option1) {
                                                  _showDrugsHistory(context,
                                                      drugsHistoryData);
                                                } else if (newValue ==
                                                    option2) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: Text(
                                                                'Xác nhận xóa'),
                                                            content: Text(
                                                                'Bạn có chắc chắn muốn xóa mục này không?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    'Không'),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context);
                                                                  await _deleteMedicalHistoryForm(
                                                                      drugsHistoryData
                                                                          .drugsID,
                                                                      "TieuSuThuoc");
                                                                  setState(() {
                                                                    drugsHistoryList
                                                                        .removeAt(
                                                                            index);
                                                                  });
                                                                },
                                                                child:
                                                                    Text('Có'),
                                                              ),
                                                            ],
                                                          ));
                                                }
                                              },
                                              itemBuilder:
                                                  (BuildContext context) => [
                                                PopupMenuItem<String>(
                                                  value: option1,
                                                  child: Text(option1,
                                                      style: TextStyleCustom
                                                          .bodySmall),
                                                ),
                                                PopupMenuItem<String>(
                                                  value: option2,
                                                  child: Text(option2,
                                                      style: TextStyleCustom
                                                          .bodySmall),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      );
                    }),
              ],
            )));
  }

  void _showDrugsHistory(BuildContext context, DrugsHistoryForm? drugsHistoryForm) {
    if (drugsHistoryForm != null) {
      drugsIDController.text = drugsHistoryForm.drugsID ?? '';
      _selectedLoaisanphamId = drugsHistoryForm.drugsType;
      drugsNameController.text = drugsHistoryForm.drugsName;
      _selectedTinhtrangsudungId = drugsHistoryForm.usageStatusDrugs;
      startDrugsController.text = drugsHistoryForm.startDrugs.toString();
      endDrugsController.text = drugsHistoryForm.endDrugs.toString();
      noteDrugsController.text = drugsHistoryForm.noteDrugs;
    }
    showModalBottomSheet(
        backgroundColor: PrimaryColor.primary_00,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var screenWidth = MediaQuery.of(context).size.width;
          var screenHeight = MediaQuery.of(context).size.height;
          final iconSize = IconSizeUtil();
          return Scaffold(
              backgroundColor: PrimaryColor.primary_00,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      SpacingUtil.spacingWidth16(context),
                      SpacingUtil.spacingHeight56(context),
                      SpacingUtil.spacingWidth16(context),
                      SpacingUtil.spacingHeight24(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: screenWidth * 0.8,
                            ),
                            child: Text('Lịch sử sử dụng thuốc', style: TextStyleCustom.heading_2b.copyWith(color: PrimaryColor.primary_10),),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close, size: iconSize.largeIcon(context), color: StatusColor.errorFull)
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight24(context)),
                      Divider(
                        color: NeutralColor.neutral_03,
                        thickness: 1.2,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Loại thuốc sử dụng',
                            style: TextStyleCustom.heading_3b
                                .copyWith(color: PrimaryColor.primary_10),
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight12(context)),
                          DropdownButtonFormField<int>(
                            value: _selectedLoaisanphamId,
                            hint: Text(
                              'Chọn loại thuốc sử dụng',
                              style: TextStyleCustom.bodySmall
                                  .copyWith(color: NeutralColor.neutral_06),
                            ),
                            isExpanded: true,
                            decoration: InputDecoration(
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
                            items: loaiSanPhamList.map((loaiSanPham) {
                              return DropdownMenuItem<int>(
                                value: loaiSanPham.typeOfDrugID,
                                child: Text(
                                  loaiSanPham.typeOfDrugName,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: PrimaryColor.primary_10),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLoaisanphamId = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Tên loại thuốc',
                        iconLabel: SvgPicture.asset(
                          "assets/icons/electronicHealthRecord/info.svg",
                          color: StatusColor.errorLighter,
                          width: iconSize.mediumIcon(context),
                          height: iconSize.mediumIcon(context),
                        ),
                        onTapIconLabel: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: PrimaryColor.primary_00,
                                title: Text(
                                    "Cảnh báo về thuốc và thực phẩm chức năng",
                                    style: TextStyleCustom.heading_2c.copyWith(color: PrimaryColor.primary_10)),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "1. Thuốc kê đơn (cần bác sĩ chỉ định)",
                                        style: TextStyleCustom.heading_3b.copyWith(color: StatusColor.successFull),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                                      Text(
                                        "• Thuốc ức chế miễn dịch (dùng sau ghép tạng, như: Cyclosporine, Tacrolimus):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Làm tăng nguy cơ bị ung thư hạch, ung thư da",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc nội tiết tố nữ (thuốc tránh thai, thuốc bổ sung estrogen/progesterone):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Có thể gây u vú, u tử cung, thậm chí ung thư vú nếu dùng lâu dài",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc điều trị ung thư vú (như Tamoxifen):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text("Dùng lâu có thể gây u tử cung",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc giảm đau cũ (Phenacetin – nay bị cấm nhiều nơi):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Có thể gây ung thư thận, ung thư bàng quang",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc an thần kinh (như: Chlorpromazine, Thioridazine):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Có thể gây phình tuyến yên, phì đại ngực ở nam",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc tăng hormone nam (Androgen, steroid):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Gây u gan, phì đại tuyến tiền liệt",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Một số thuốc lợi tiểu (như Hydrochlorothiazide):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Dùng lâu ngoài nắng có thể tăng nguy cơ ung thư da",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc điều trị ung thư máu (Mercaptopurine, Thioguanine):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Có thể gây khối u thứ phát do biến đổi gen",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                                color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "2. Thuốc không kê đơn (mua tại hiệu thuốc không cần đơn bác sĩ)",
                                        style: TextStyleCustom.heading_3b.copyWith(color: StatusColor.warningFull),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                                      Text(
                                        "• Thuốc giảm đau, hạ sốt (Paracetamol, Ibuprofen, Aspirin):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Dùng quá liều có thể gây tổn thương gan, dạ dày, tăng nguy cơ u gan hoặc u thận nếu dùng liên tục",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc trị trào ngược, ợ nóng (Ranitidine - nay nhiều nước đã cấm):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Có chứa tạp chất dễ gây ung thư",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc dị ứng (Chlorpheniramine, Diphenhydramine):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Dùng dài lâu hiếm khi có thể làm tăng hormone, gây u lành tuyến vú",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "3. Thực phẩm chức năng (TPCN)",
                                        style: TextStyleCustom.heading_3b.copyWith(color: StatusColor.informationFull),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                                      Text(
                                        "• Sữa đậu nành, viên mầm đậu nành, isoflavone:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Nếu dùng nhiều có thể kích thích u xơ tử cung, u vú phát triển",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thực phẩm tăng cơ – tăng testosterone (chứa steroid hoặc kích hormone):",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Có thể gây u gan, phì đại tuyến tiền liệt, rối loạn hormone",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Thuốc giảm cân trôi nổi:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Một số chứa chất cấm, có thể gây tổn thương gan, ung thư thận",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
                                      Text(
                                        "• Viên bổ não chứa Ginkgo Biloba liều cao:",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                            color: PrimaryColor.primary_10),
                                      ),
                                      Text(
                                        "Có thể làm tăng nguy cơ u gan hoặc u tuyến giáp trên động vật",
                                        style: TextStyleCustom.bodySmall
                                            .copyWith(
                                            color: NeutralColor.neutral_06),
                                      ),
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                                      SizedBox(height: SpacingUtil.spacingHeight12(context)),
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
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Đóng dialog
                                    },
                                    child: Text("Đóng",
                                        style: TextStyleCustom.bodyLarge
                                            .copyWith(
                                                color:
                                                    PrimaryColor.primary_05)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        hintText: 'Điền tên loại thuốc',
                        controller: drugsNameController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tình trạng sử dụng thuốc',
                            style: TextStyleCustom.heading_3b
                                .copyWith(color: PrimaryColor.primary_10),
                          ),
                          SizedBox(height: SpacingUtil.spacingHeight12(context)),
                          DropdownButtonFormField<int>(
                            value: _selectedTinhtrangsudungId,
                            hint: Text(
                              'Chọn tình trạng sử dụng',
                              style: TextStyleCustom.bodySmall
                                  .copyWith(color: NeutralColor.neutral_06),
                            ),
                            isExpanded: true,
                            decoration: InputDecoration(
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
                            items: tinhTrangSuDungList.map((tinhTrangSuDung) {
                              return DropdownMenuItem<int>(
                                value: tinhTrangSuDung.usageStatusID,
                                child: Text(
                                  tinhTrangSuDung.usageStatusName,
                                  style: TextStyleCustom.bodySmall
                                      .copyWith(color: PrimaryColor.primary_10),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedTinhtrangsudungId = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  _presentDatePickerForStart(field: 'startPD'),
                              child: AbsorbPointer(
                                // Ngăn người dùng nhập tay
                                child: CustomTextInput(
                                  type: TextFieldType.textIconRight,
                                  state: TextFieldState.defaultState,
                                  label: 'Bắt đầu',
                                  hintText: "Chọn thời gian",
                                  controller: startDrugsController,
                                  iconTextInput: Icons.calendar_month,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: SpacingUtil.spacingWidth12(context)),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  _presentDatePickerForEnd(field: 'endPD'),
                              child: AbsorbPointer(
                                child: CustomTextInput(
                                  type: TextFieldType.textIconRight,
                                  state: TextFieldState.defaultState,
                                  label: 'Kết thúc',
                                  hintText: "Chọn thời gian",
                                  controller: endDrugsController,
                                  iconTextInput: Icons.calendar_month,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      CustomTextInput(
                        type: TextFieldType.text,
                        state: TextFieldState.defaultState,
                        label: 'Ghi chú',
                        hintText: 'Điền ghi chú',
                        controller: noteDrugsController,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: SpacingUtil.spacingHeight16(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: ButtonState.outline,
                              text: 'Xóa thông tin',
                              width: double.infinity,
                              height: SpacingUtil.spacingHeight56(context),
                              onPressed: () {
                                _resetFormDrugsHistory();
                              },
                            ),
                          ),
                          SizedBox(width: SpacingUtil.spacingWidth12(context)),
                          Expanded(
                            child: CustomButton(
                              type: ButtonType.standard,
                              state: ButtonState.fill1,
                              text: 'Lưu thông tin',
                              width: double.infinity,
                              height: SpacingUtil.spacingHeight56(context),
                              onPressed: () {
                                _submitFormPrescriptionDrugs();
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
