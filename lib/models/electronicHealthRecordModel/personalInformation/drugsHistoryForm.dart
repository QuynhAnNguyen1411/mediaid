
class DrugsHistoryForm {
  String? drugsID;
  String accountID;
  int drugsType;
  String drugsName;
  int usageStatusDrugs;
  String? startDrugs;
  String? endDrugs;
  String noteDrugs;

  DrugsHistoryForm({
    this.drugsID,
    required this.accountID,
    required this.drugsType,
    required this.drugsName,
    required this.usageStatusDrugs,
    required this.startDrugs,
    required this.endDrugs,
    required this.noteDrugs,
  }) ;

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'drugsID': drugsID,
      'accountID': accountID,
      'drugsType': drugsType,
      'drugsName': drugsName,
      'usageStatusDrugs': usageStatusDrugs,
      'startDrugs': startDrugs ?? null,
      'endDrugs': endDrugs ?? null,
      'noteDrugs': noteDrugs,
    };
  }

  // Phương thức chuyển JSON -> Object
  factory DrugsHistoryForm.fromJson(Map<String, dynamic> json) {
    return DrugsHistoryForm(
      drugsID: json['drugsID'],
      accountID: json['accountID'],
      drugsType: json['drugsType'],
      drugsName: json['drugsName'],
      usageStatusDrugs: json['usageStatusDrugs'],
      startDrugs: json['startDrugs'],
      endDrugs: json['endDrugs'],
      noteDrugs: json['noteDrugs'],
    );
  }
}
