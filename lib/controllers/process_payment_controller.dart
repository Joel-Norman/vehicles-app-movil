import 'package:vehicle_app/app/aplication/ports/outputs/process_payment_port.dart';
import 'package:vehicle_app/app/domain/process_payment.dart';
import 'package:vehicle_app/app/domain/response_payment.dart';
import 'package:vehicle_app/app/infrastructure/adapters/outputs/process_payment_adapter.dart';

class ProcessPaymentController {
  late ProcessPaymentPort portPayment;

  ProcessPaymentController() {
    portPayment=ProcessPaymentAdapter();
  }

  Future<ResponsePayment> processPayment(PaymentInfo payment, int id) async {
    return await portPayment.processPayment(payment, id);
  }
}