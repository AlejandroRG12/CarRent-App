class LoginInterface {
  String email;
  String password;

  LoginInterface({
    required this.email,
    required this.password,
  });

  factory LoginInterface.fromJson(Map<String, dynamic> json) {
    return LoginInterface(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
