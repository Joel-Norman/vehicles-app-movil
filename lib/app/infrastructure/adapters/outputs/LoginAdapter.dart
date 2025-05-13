import 'dart:convert';

import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:vehicle_app/app/aplication/ports/outputs/LoginPort.dart';
import 'package:vehicle_app/app/domain/Login.dart';
import 'package:vehicle_app/app/domain/Register.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_app/app/domain/Session.dart';
class LoginAdaper implements LoginPort{


  @override
  Future<Session> loginUser(Login login) async{
    final url = Uri.parse('$urlApi/login');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(login),
    );

    if (response.statusCode == 200) {
      final res=jsonDecode(response.body);
      if(res['success']){
        print(res['data']);
        return Session.fromJson(res['data']);
      }else{
        throw Exception('${res['message']}');
      }
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

}