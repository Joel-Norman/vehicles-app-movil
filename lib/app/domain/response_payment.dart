class ResponsePayment {
  String? type;
  String? html;
  String? url;

  ResponsePayment({this.type, this.html, this.url});

  // Método para convertir un JSON a un objeto ContentInfo
  factory ResponsePayment.fromJson(Map<String, dynamic> json) {
    return ResponsePayment(
      type: json['type'],
      html: json['html'],
      url: json['url'],
    );
  }

  // Método para convertir el objeto ContentInfo a JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'html': html,
      'url': url,
    };
  }
}