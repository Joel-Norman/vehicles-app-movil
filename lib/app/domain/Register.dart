class Register{
  String email;
  String password;
  String repeatPassword;

  Register({
    required this.email,
    required this.password,
    required this.repeatPassword,
  });

  // Método para convertir un JSON en un objeto de tipo Register
  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      email: json['email']??"",
      password: json['password']??"",
      repeatPassword: json['repeatPassword']??"",
    );
  }

  // Método opcional para convertir un objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'repeatPassword': repeatPassword,
    };
  }
}