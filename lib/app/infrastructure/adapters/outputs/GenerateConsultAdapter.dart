import 'dart:convert';

import 'package:vehicle_app/app/aplication/ports/outputs/GenerateConsultPort.dart';
import 'package:vehicle_app/app/domain/GenerateConsult.dart';
import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/main.dart';
class GenerateConsultAdapter implements GenerateConsultPort{
  @override
  Future<GenerateConsult> generateConsult(GenerateConsult consult) async{
    final url = Uri.parse('$urlApi/consult?key=${session.token}');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${session.token}',
        'Content-Type': 'application/json'},
      body: jsonEncode(consult),
    );

    if (response.statusCode == 200) {
      final res=jsonDecode(response.body);
      if(res['success']){
        print((res['data']));
        return GenerateConsult.fromJson(res['data']);
      }else{
        throw Exception('${res['message']}');
      }
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

}