class LifestyleSurveyForm{
  String? lifestyleSurveyID;
  String accountID;
  List<int> isCheckedList;
  int? workingEnvironment;
  String noteLifestyleSurvey;

  LifestyleSurveyForm({
    this.lifestyleSurveyID,
    required this.accountID,
    required this.isCheckedList,
    required this.workingEnvironment,
    required this.noteLifestyleSurvey,
  });

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'loiSongNguoiBenhID': lifestyleSurveyID,
      'accountID': accountID,
      'thoiQuenLoiSongs': isCheckedList,
      'moiTruongID': workingEnvironment,
      'ghiChu': noteLifestyleSurvey,
    };
  }

  // Phương thức chuyển JSON -> Object
  factory LifestyleSurveyForm.fromJson(Map<String, dynamic> json) {
    return LifestyleSurveyForm(
      lifestyleSurveyID: json['lifestyleSurveyID'],
      accountID: json['accountID'],
      isCheckedList: json['isCheckedList'],
      workingEnvironment: json['workingEnvironment'],
      noteLifestyleSurvey: json['noteLifestyleSurvey'],
    );
  }
}