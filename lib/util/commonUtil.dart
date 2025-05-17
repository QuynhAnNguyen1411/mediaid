class CommonUtil {
  static DateTime? stringToDateTime(String? dateString) {
    try {
      if (dateString == null || dateString.isEmpty) return null;
      return DateTime.parse(dateString);
    } catch (e) {
      print("❌ Lỗi khi parse DateTime: $e");
      return null;
    }
  }

  static double? convertStringToDouble(dynamic input) {
    if (input == null) return null;

    try {
      if (input is num) return input.toDouble();
      return double.parse(input.toString().replaceAll(',', '.'));
    } catch (e) {
      print('Lỗi chuyển đổi sang double: $e');
      return null;
    }
  }

}
