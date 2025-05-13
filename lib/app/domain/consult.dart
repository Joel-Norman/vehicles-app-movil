  class Consult{
    final int id;
    final String nit;
    final String placa;
    final String status;
    final String inform;
    final String mes;        // Nuevo campo: mes
    final String fecha;      // Nuevo campo: fecha
    final String diaSemana;  // Nuevo campo: día de la semana
    final String hora;  
    final DateTime date;     // Nuevo campo: hora
    Consult({
      required this.id,
      required this.nit,
      required this.placa,
      required this.status,
      required this.inform,
      required this.mes,
      required this.fecha,
      required this.diaSemana,
      required this.hora,
      required this.date
    });

  // Constructor para crear un objeto Vehicle desde JSON
  factory Consult.fromJson(Map<String, dynamic> json) {
    return Consult(
      id: json['id']??'',
      nit: json['nit']??'',
      placa: json['placa']??'',
      status: json['status']??'', // Deserialización del objeto User
      inform: json['inform']??'',
      mes:json['mes']??'',
      fecha:json['fecha']??'',
      diaSemana: json['diaSemana']??'',
      hora: json['hora']??'',

      date: DateTime.parse(json['date']),
    );
  }

  // Método para convertir un objeto Vehicle a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nit': nit,
      'placa': placa,
      'status': status,
      'inform': inform,
    };
  }
}