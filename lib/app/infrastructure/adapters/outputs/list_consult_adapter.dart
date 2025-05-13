import 'dart:convert';


import 'package:vehicle_app/app/aplication/ports/outputs/list_consult_port.dart';
import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/app/domain/consult.dart';
import 'package:vehicle_app/main.dart';
class ListConsultAdapter implements ListConsultPort{

  @override
  Future<List<Consult>> listConsult(String username) async{
    final url = Uri.parse('$urlApi/consult/$username?key=${session.token}');
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);

        // Parsear el JSON después de la decodificación
      final res = jsonDecode(decodedResponse);
      //final res=jsonDecode(response.body);
      if(res['success']){
        print(res['data']);
        print("Lista de consula");
        List<Consult> consults = (res['data'] as List)
          .map((consultJson) => Consult.fromJson(consultJson))
          .toList();
        print(consults);
        return consults;
      }else{
        throw Exception('${res['message']}');
      }
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

}