
import 'package:flutter/material.dart';
import 'package:vehicle_app/app/domain/Register.dart';
import 'package:vehicle_app/controllers/RegisterController.dart';
import 'package:vehicle_app/screens/login/login_screen.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => RegisterScreenState();

}

class RegisterScreenState extends State<RegisterScreen>{
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController = TextEditingController();
  RegisterController registerController = RegisterController();

  void register(BuildContext context) async {
    Register register=Register(email: emailController.text, password: passwordController.text, repeatPassword: passwordRepeatController.text);
    try {
      final user = await registerController.register(register);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen()),
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
                  Text("Bienvenido!!",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),)
                ]
              ),
              )
            ),
          ),
          const SizedBox(height: 10,),
          const Center(
            child: Text("Registrate para iniciar" , style: TextStyle(fontWeight: FontWeight.bold),),
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
                const Text("Pin"),
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
                const SizedBox(height: 30),
                const Text("Repetir Pin:"),
                TextFormField(
                  controller: passwordRepeatController,
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
                      return 'Por favor repite tu contraseña';
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      register(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor espere...')),
                        );
                    },
                    child:const Text('Registrar'),
                  )
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("¿Tienes una cuenta? "),
              GestureDetector(
                child:const Text("Ingresa aqui",style: TextStyle(color: Colors.blue)),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen()),
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