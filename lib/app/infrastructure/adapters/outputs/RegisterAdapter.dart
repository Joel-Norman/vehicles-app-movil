import 'dart:convert';

import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:vehicle_app/app/aplication/ports/outputs/RegisterPort.dart';
import 'package:vehicle_app/app/domain/Register.dart';
import 'package:http/http.dart' as http;
class RegisterAdaper implements RegisterPort{

  @override
  Future<Register> registerUser(Register register) async {
    final url = Uri.parse('$urlApi/register');
    if(register.password!=register.repeatPassword){
      throw Exception('Contraseñas no coinciden.');
    }
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(register),
    );

    if (response.statusCode == 200) {
      final res=jsonDecode(response.body);
      if(res['success']){
        return Register.fromJson((res['data']));
      }else{
        throw Exception('${res['message']}');
      }
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

}