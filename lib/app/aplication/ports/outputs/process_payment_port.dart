import 'package:vehicle_app/app/domain/process_payment.dart';
import 'package:vehicle_app/app/domain/response_payment.dart';

abstract class ProcessPaymentPort{
  Future<ResponsePayment> processPayment(PaymentInfo payment,int id);
}