
import 'package:flutter/material.dart';
import 'package:vehicle_app/app/domain/Login.dart';
import 'package:vehicle_app/config/session_config.dart';
import 'package:vehicle_app/controllers/LoginController.dart';
import 'package:vehicle_app/main.dart';
import 'package:vehicle_app/screens/home/home_screen.dart';
import 'package:vehicle_app/screens/navigation/navigation_screen.dart';
import 'package:vehicle_app/screens/register/register_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();

}

class LoginScreenState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(); 
  LoginController loginController = LoginController();
  SessionConfig config=SessionConfig();

  void login(BuildContext context) async {
    Login login=Login(email: emailController.text, password: passwordController.text);
    try {
      session = await loginController.login(login);
      config.saveSessionData(session);
      config.saveSessionDate();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationScreen()),
        );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            decoration:const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Color.fromARGB(255, 87, 172, 241),],
              ),
            ),
            child: const Center(
              child:SizedBox(
                height: 200,
                child: Column(
                children: [
                  //Icon(Icons.emoji_transportation,size: 50,color: Colors.white,),//cambiar por imagen
                  Image(
                    image: AssetImage("assets/icon/icon.png"),
                    height: 128,
                    ),
                  Text("Hola!!",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),)
                ]
              ),
              )
            ),
          ),
          const SizedBox(height: 10,),
          const Center(
            child: Text("Inicia sesion para continuar" , style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding:const EdgeInsets.only(left: 40,right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Numero de Telefono:"),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "",
                    border: UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                const Text("Pin:"),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  maxLength: 4,
                  decoration: InputDecoration(
                    
                    hintText: "••••",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border:const UnderlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                  },
                ),
                //const SizedBox(height: 20),
                //const Row(
                //  children: [Expanded(child: SizedBox()),Text("¿Olvidaste tu contraseña?",textAlign:TextAlign.left,style: TextStyle(color: Colors.blue),)],
                //),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(33, 150, 243, 1)),
                    onPressed: () {
                      login(context);
                      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationScreen()),
        );*/
                    },
                    child:const Text('Ingresar'),
                  )
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("¿No tienes una cuenta? "),
              GestureDetector(
                child:const Text("Registrate ahora",
                  style: TextStyle(
                    color: Colors.blue
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                    );
                },
              )
              

            ],
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }

}