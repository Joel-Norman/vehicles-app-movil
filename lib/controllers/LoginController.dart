import 'package:vehicle_app/app/aplication/ports/outputs/LoginPort.dart';
import 'package:vehicle_app/app/domain/Login.dart';
import 'package:vehicle_app/app/domain/Session.dart';
import 'package:vehicle_app/app/infrastructure/adapters/outputs/LoginAdapter.dart';

class LoginController {
  late LoginPort portLogin;

  LoginController() {
    portLogin=LoginAdaper();
  }

  Future<Session> login(Login login) async {
    return await portLogin.loginUser(login);
  }
}