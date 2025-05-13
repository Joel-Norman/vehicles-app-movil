import 'dart:convert';

import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:vehicle_app/app/aplication/ports/outputs/ads_port.dart';
import 'package:vehicle_app/app/domain/Ad.dart';
import 'package:vehicle_app/main.dart';
import 'package:http/http.dart' as http;
class AdsAdapter implements AdsPort{
  @override
  Future<List<Ad>> listAds()async {
    final url = Uri.parse('$urlApi/ads?key=${session.token}');
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      //final decodedResponse = utf8.decode(response.bodyBytes);

        // Parsear el JSON después de la decodificación
      final res = jsonDecode(response.body);
      //final res=jsonDecode(response.body);
      if(res['success']){
        print(res['data']);
        print("Lista de consula");
        List<Ad> consults = (res['data'] as List)
          .map((consultJson) => Ad.fromJson(consultJson))
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