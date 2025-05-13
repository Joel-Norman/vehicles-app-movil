

class GenerateConsult {
  int? id;
  String? username;
  String? nit;
  String? placa;
  bool? freeConsult;
  GenerateConsult({this.id,this.username, this.nit,this.placa, this.freeConsult});

  // Convert Session object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'username': username,
      'nit': nit,
      'placa':placa,
      'freeConsult':freeConsult
    };
  }

  // Create Session object from JSON
  factory GenerateConsult.fromJson(Map<String, dynamic> json) {
    return GenerateConsult(
      id:json['id']??0,
      username: json['username']??'',
      nit: json['nit']??'',
      placa: json['placa']??'',
      freeConsult: json['freeConsult']
    );
  }
}