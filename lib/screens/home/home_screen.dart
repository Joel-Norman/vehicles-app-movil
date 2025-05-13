
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:vehicle_app/app/domain/Ad.dart';
import 'package:vehicle_app/app/domain/GenerateConsult.dart';
import 'package:vehicle_app/app/domain/process_payment.dart';
import 'package:vehicle_app/app/domain/response_payment.dart';
import 'package:vehicle_app/controllers/GenerateConsultController.dart';
import 'package:vehicle_app/controllers/ads_controller.dart';
import 'package:vehicle_app/controllers/process_payment_controller.dart';
import 'package:vehicle_app/main.dart';
import 'package:vehicle_app/screens/web_view_screen/web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';
class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  final List<String> _options = ['P', 'C', 'A', 'M','CD','CC','DIS','TC','O','U','MI','STP','TRC','PNC'];
  List<Ad> ads=[];
  String? _selectedOption;
  final TextEditingController nitController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  GenerateConsultController generateController = GenerateConsultController();
  ProcessPaymentController processController = ProcessPaymentController();
  AdsController adsController = AdsController();
  String? selectedValue;
  
  void generateConsult(BuildContext context) async {
    GenerateConsult consult=GenerateConsult(
      id: 0,
      nit:nitController.text,
      placa: _selectedOption!+placaController.text,
      username: session.email,
      freeConsult: selectedValue=="CONSULTA GRATUITA"
    );
    try {
      GenerateConsult consultResp = await generateController.generateConsult(consult);
      nitController.text='';
      placaController.text='';
      print(consultResp.toJson());
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 50, left: 16, right: 16),
          content: Text('Su consulta fue generada con exito, por favor continue con el pago para poder tener acceso al informe.')),
      );*/
      PaymentInfo payment=PaymentInfo(
        billToAddress2: "",
        billToCity: "",
        billToAddress: "",
        billToCountry: "",
        billToEmail: session.email,
        billToFirstName: "",
        billToLastName: "",
        billToState: "",
        billToTelephone: "",
        billToZipPostCode: "",
      );
      //si es de paga hago la consulta
      //sino mando un mensaje por pantalla
      if(selectedValue!="CONSULTA GRATUITA"){
        ResponsePayment resp=  await processController.processPayment(payment,consultResp.id??0);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: resp.url??"",)),
          );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Su consulta fue generada, cuando el informe este listo lo podra ver en la seccion de Consultas')),
              );
      }
      
      
      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            int id = consultResp.id??0;
                            return FormPaymentScreen(id: id);
                          }),
                      );*/
    } catch (e) {
      print(e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }
  void listAds() async {
    try {
      List<Ad> aux= await adsController.listAds();
      setState(() {
        ads=aux;
      });
      
      
    } catch (e) {
      print(e);
    }
  }
  Future<void> openURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication); // Abre en el navegador externo
      }
    } catch (e) {
      print(e);
    }
    
  }
  @override
  void initState() {
    super.initState();
    listAds();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.only(left: 15,right:15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:EdgeInsets.only(top: 15,bottom: 15),
              child:Text("Consultar vehiculo",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),) ,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4)
              ),
              child:Padding(
                padding:const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Placa del vehiculo:",style: TextStyle(color: Colors.white),),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: DropdownButton<String>(
                                  iconEnabledColor: Colors.white,
                                  underline: Container(),
                                  isDense: true,
                                value: _selectedOption,
                                hint: Text('XXX',style: TextStyle(color: Colors.white70),),
                                items: _options.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedOption = newValue;
                                  });
                                },
                                selectedItemBuilder: (BuildContext context) {
                                return _options.map((String item) {
                                  return Text(
                                    item,
                                    style: const TextStyle(
                                      color: Colors.white,
                                 
                                      //fontSize: 30,
                                      //color: item == currentValue ? Colors.red : Colors.black, // Cambia el color del ítem seleccionado
                                    ),
                                  );
                                }).toList();
                            },
                              ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: TextFormField(
                                  maxLengthEnforcement: MaxLengthEnforcement.enforced, 
                                  maxLength: 6,
                                  controller:placaController,
                                  decoration:const InputDecoration(
                                    counterText: "",
                                    hintText: "XXXXXX",
                                    border: UnderlineInputBorder(),
                                    
                                    hintStyle: TextStyle(color: Colors.white70),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white70), // Color del borde cuando no está enfocado
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white), // Color del borde cuando está enfocado
                                    ),
                                  ),
                                  style:const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingresa la placa';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text("NIT del dueño del vehiculo:",style: TextStyle(color: Colors.white),),
                          TextFormField(
                            controller: nitController,
                            decoration:const InputDecoration(
                              hintText: "AAAAA",
                              border: UnderlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70), // Color del borde cuando no está enfocado
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white), // Color del borde cuando está enfocado
                              ),
                            ),
                            style:const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa el codigo';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text("Gratuita/Completa:",style: TextStyle(color: Colors.white),),
                              SizedBox(width: 10,),
                              Tooltip(
                                message: "CONSULTA GRATUITA: Consulta de multas en las municipalidades.\nCONSULTA COMPLETA: Consulta del estado legal del vehículo.",
                                child: Icon(Icons.info_outline_rounded,size: 16,color: Colors.white,),
                              ),
                            ],
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedValue,
                            items: ['CONSULTA GRATUITA', 'CONSULTA COMPLETA'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            iconEnabledColor: Colors.white,
                            selectedItemBuilder: (BuildContext context) {
                                return ['CONSULTA GRATUITA', 'CONSULTA COMPLETA'].map((String item) {
                                  return Text(
                                    item,
                                    style: const TextStyle(
                                      color: Colors.white,
                                 
                                      //fontSize: 30,
                                      //color: item == currentValue ? Colors.red : Colors.black, // Cambia el color del ítem seleccionado
                                    ),
                                  );
                                }).toList();
                            },
                            decoration: const InputDecoration(
                              hintText: "Selecciona una opción",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            //style: const TextStyle(color: Colors.white),
                            //dropdownColor: Colors.black87, // Fondo del menú desplegable
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor selecciona una opción';
                              }
                              return null;
                            },
                          )
                        
                        ],
                      ),
                    
                      
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      
                      height: 60,
                      width: 60,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child:IconButton(
                        onPressed: (){
                          generateConsult(context);
                        }, 
                        icon: const Icon(Icons.send_outlined,color: Colors.blue,),
                      ),
                    )
                  ],
                ),
              ) 
              
            ),
            const Padding(
              padding:EdgeInsets.only(top: 30,bottom: 15),
              child:Text("Seccion de Anuncios",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),) ,
            ),
            Expanded( // Usamos Expanded para que el Grid ocupe el espacio restante
              child: GridView.builder(
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Número de columnas
                  crossAxisSpacing: 10, // Espacio entre columnas
                  mainAxisSpacing: 10, // Espacio entre filas
                  childAspectRatio: 1.0, // Relación de aspecto de cada elemento
                ),
                itemCount: ads.length, // Número de elementos
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("$urlApi/inform/${ads[index].image}"),
                          fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      
                    ),
                    onTap: (){
                      openURL(ads[index].url);
                    },
                  );
                },
              ),
            ),  
          ],
        ),
      );
  }
}
