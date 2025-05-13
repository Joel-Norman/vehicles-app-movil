import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicle_app/app/domain/GenerateConsult.dart';
import 'package:vehicle_app/app/domain/process_payment.dart';
import 'package:vehicle_app/app/domain/response_payment.dart';
import 'package:vehicle_app/controllers/GenerateConsultController.dart';
import 'package:vehicle_app/controllers/process_payment_controller.dart';
import 'package:vehicle_app/main.dart';
import 'package:vehicle_app/screens/web_view_screen/web_view_screen.dart';

class ServicesScreen extends StatefulWidget{
  const ServicesScreen({super.key});

  @override
  State<StatefulWidget> createState() => ServicesScreenState();

}

class ServicesScreenState extends State<ServicesScreen>{
  final List<String> _options = ['P', 'C', 'A', 'M','CD','CC','DIS','TC','O','U','MI','STP','TRC','PNC'];
  String? _selectedOption;
  final TextEditingController nitController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  GenerateConsultController generateController = GenerateConsultController();
  ProcessPaymentController processController = ProcessPaymentController();
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.only(left: 15,right:15),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.design_services),
              title: Text("Servicios"),
              trailing: ElevatedButton(
                onPressed: () {
                  
                }, 
                child: Text("Contactar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0),
                ),
              tileColor: Color.fromARGB(24, 28, 120, 196),
              
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.directions_car_filled_sharp),
              title: Text("Traspasos de vehiculos"),
              trailing: ElevatedButton(
                onPressed:() {
                  
                },
                child: Text("Contactar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0),
                ),
              tileColor: Color.fromARGB(24, 28, 120, 196),
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.gavel_outlined),
              title: Text("Servicios legales"),
              trailing: ElevatedButton(
                onPressed: () {
                  
                }, 
                child: Text("Contactar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0),
                ),
              tileColor: Color.fromARGB(24, 28, 120, 196),
            )
          ],
        )
      );
  }
}
