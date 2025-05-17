class LogInForm{
  String personalIdentifier;
  String password;


  LogInForm({
    required this.personalIdentifier,
    required this.password,
  });

  // Phương thức chuyển Object -> JSON
  Map<String, dynamic> toJson() {
    return {
      'personalIdentifier': personalIdentifier,
      'password': password,
    };
  }
}
