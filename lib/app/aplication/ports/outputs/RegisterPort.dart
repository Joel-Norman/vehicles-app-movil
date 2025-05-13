import 'package:vehicle_app/app/domain/Register.dart';

abstract class RegisterPort{
  Future<Register> registerUser(Register register);
}