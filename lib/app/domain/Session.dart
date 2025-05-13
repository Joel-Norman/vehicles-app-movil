class Session {
  String? email;
  String? token;

  Session({this.email, this.token});

  // Convert Session object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
    };
  }

  // Create Session object from JSON
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      email: json['email'],
      token: json['token'],
    );
  }
}