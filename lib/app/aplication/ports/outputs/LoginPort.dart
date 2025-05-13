import 'package:vehicle_app/app/domain/Login.dart';
import 'package:vehicle_app/app/domain/Session.dart';

abstract class LoginPort{
  Future<Session> loginUser(Login login);
}