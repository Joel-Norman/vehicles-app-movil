
class Login {
  String? email;
  String? password;

  Login({this.email, this.password});

  // Convert Login object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Create Login object from JSON
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      email: json['email'],
      password: json['password'],
    );
  }
}