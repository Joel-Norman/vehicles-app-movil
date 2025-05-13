import 'package:flutter/material.dart';
import 'package:vehicle_app/config/session_config.dart';
import 'package:vehicle_app/screens/history/history_screen.dart';
import 'package:vehicle_app/screens/home/home_screen.dart';
import 'package:vehicle_app/screens/login/login_screen.dart';
import 'package:vehicle_app/screens/services/services_screen.dart';

class NavigationScreen extends StatefulWidget{
  const NavigationScreen({super.key});

  @override
  State<StatefulWidget> createState() => NavigationScreenState();

}

class NavigationScreenState extends State<NavigationScreen>{
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  SessionConfig config=SessionConfig();
  
  Future<void> close() async{
    if(await config.closeSession()){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            close();
          }, icon:const Icon(Icons.logout,color: Colors.blue,))
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title:Container(
          height: 40,
          width: 69,
          decoration:const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/icon/icon.png"), fit: BoxFit.cover)
          ),
        )//const Text("Auto Info",style: TextStyle(color: Colors.black),),
      ),
      body:PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index; // Cambia el índice al deslizar entre páginas
          });
        },
        children: [
          HomeScreen(), // Pantalla Home
          //PlaceholderScreen(title: "Payments"), // Pantalla Payments (Placeholder)
          HistoryScreen(), // Pantalla History
          ServicesScreen(), 
          //PlaceholderScreen(title: "Account"), // Pantalla Account (Placeholder)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Actualiza el índice del BottomNavigationBar
          });
          _pageController.jumpToPage(index); // Cambia a la página seleccionada
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        unselectedLabelStyle:const TextStyle(color: Colors.black54),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          
          BottomNavigationBarItem(icon: Icon(Icons.history_outlined),label: "Consultas"),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone_rounded),label: "Servicios"),
          
        ],),
    );
  }
}