import 'package:vehicle_app/app/aplication/ports/outputs/RegisterPort.dart';
import 'package:vehicle_app/app/domain/Register.dart';
import 'package:vehicle_app/app/infrastructure/adapters/outputs/RegisterAdapter.dart';

class RegisterController {
  late RegisterPort portRegister;

  RegisterController() {
    portRegister=RegisterAdaper();
  }

  Future<Register> register(Register register) async {
    return await portRegister.registerUser(register);
  }
}