import 'dart:convert';

import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:vehicle_app/app/aplication/ports/outputs/process_payment_port.dart';
import 'package:vehicle_app/app/domain/process_payment.dart';
import 'package:vehicle_app/app/domain/response_payment.dart';
import 'package:vehicle_app/main.dart';
import 'package:http/http.dart' as http;
class ProcessPaymentAdapter implements ProcessPaymentPort{
  @override
  Future<ResponsePayment> processPayment(PaymentInfo payment, int id) async {
    final url = Uri.parse('$urlApi/payment/$id?key=${session.token}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payment),
    );
    if (response.statusCode == 200) {

        // Parsear el JSON después de la decodificación
      final res = jsonDecode(response.body);
      //final res=jsonDecode(response.body);
      if(res['success']){
        return ResponsePayment.fromJson(res['data']);
      }else{
        throw Exception('${res['message']}');
      }
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

}