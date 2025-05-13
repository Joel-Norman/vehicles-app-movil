import 'package:flutter/material.dart';
import 'package:vehicle_app/app/domain/Session.dart';
import 'package:vehicle_app/config/session_config.dart';
import 'package:vehicle_app/main.dart';
import 'package:vehicle_app/screens/home/home_screen.dart';
import 'dart:async';

import 'package:vehicle_app/screens/login/login_screen.dart';
import 'package:vehicle_app/screens/navigation/navigation_screen.dart';
class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();

}

class SplashScreenState extends State<SplashScreen>{
  SessionConfig config=SessionConfig();
  @override
  void initState() {
    super.initState();
    validSessionData(context);
  }

  Future<void> validSessionData(BuildContext context) async {
    try {
      if(await config.isValidSession()){
        session =await config.getSessionData();
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen()),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Color de fondo del splash
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo o imagen
            /*Icon(
              Icons.flash_on, // Puedes cambiarlo por tu logo
              color: Colors.white,
              size: 100.0,
            ),*/
            SizedBox(height: 20),
            // Indicador de carga
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}