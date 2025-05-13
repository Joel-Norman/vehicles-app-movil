import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_app/app/domain/Session.dart';

class SessionConfig{
  Future<void> saveSessionData(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', session.email ?? '');
    await prefs.setString('token', session.token ?? '');
  }

  Future<Session> getSessionData() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? token = prefs.getString('token');
    return Session(email: email, token: token);
  }

  Future<void> saveSessionDate() async {
    final prefs = await SharedPreferences.getInstance();
    DateTime date = DateTime.now();
    await prefs.setString('fecha', date.toIso8601String()); // Recupera el valor
  }
  Future<bool> isValidSession() async {
    final prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('fecha');
    if (dateString != null) {
      DateTime date=DateTime.parse(dateString);
      
      DateTime now = DateTime.now();

      Duration difference = now.difference(date);

      return difference.inDays.abs() < 2; 
    }
    return false;
  }

  Future<bool> closeSession() async {
    final prefs = await SharedPreferences.getInstance();
    bool email =await prefs.remove('email');
    bool token = await prefs.remove('token');
    bool dateString = await prefs.remove('fecha');
    return email&&token&&dateString;
  }
}