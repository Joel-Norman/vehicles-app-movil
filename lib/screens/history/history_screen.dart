import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vehicle_app/app/domain/consult.dart';
import 'package:vehicle_app/controllers/GenerateConsultController.dart';
import 'package:vehicle_app/controllers/list_consult_controller.dart';
import 'package:vehicle_app/main.dart';
import 'package:vehicle_app/screens/view_pdf/view_pdf_screen.dart';

class HistoryScreen extends StatefulWidget{
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => HistoryScreenState();

}

class HistoryScreenState extends State<HistoryScreen>{
  List<Consult> data=[];
  List<Consult> originalData=[];
  String? selectedStatus;
  DateTime? selectedDate;
  ListConsultController listController = ListConsultController();
  

  GenerateConsultController generateController = GenerateConsultController();
  
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listConsult(context);

  }
  void listConsult(BuildContext context) async {
    try {
      final resp = await listController.listConsult(session.email??"");
      setState(() {
        originalData=resp;
        data=resp;
      });
      
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin:const EdgeInsets.only(top: 50, left: 16, right: 16),
          content: Text('$e')),
      );
    }
  }
  void filterItems() {
    setState(() {
      data = originalData.where((item) {
        final matchesStatus =
            selectedStatus == null || item.status== selectedStatus;
        final matchesDate = selectedDate == null ||
            item.date.year == selectedDate!.year && item.date.month == selectedDate!.month && item.date.day == selectedDate!.day;
        return matchesStatus && matchesDate;
      }).toList();
    });
  }
  // Mostrar el selector de fecha
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      //filterItems(); // Filtrar después de seleccionar la fecha
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:const EdgeInsets.only(left: 15,right:15),
        child:Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(24, 28, 120, 196),
                borderRadius: BorderRadius.circular(4)
              ),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                      hint: Text("Estado"),
                      value: selectedStatus,
                      items: [{'value':"AVAILABLE",'label':"Disponible"},{'value':"NOT_AVAILABLE",'label':"Pendiente"}].map((dynamic option) {
                                    return DropdownMenuItem<String>(
                                      value: option['value'],
                                      child: Text(option['label']),
                                    );
                                  }).toList(), 
                      onChanged: (item)=>{
                        selectedStatus=item
                      }),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        pickDate(context);
                      },
                      decoration: InputDecoration(
                      hintText: selectedDate == null
                          ? 'DD/MM/AAAA'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      border: InputBorder.none
                    ),
                    )
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    color: Colors.blue,
                    onPressed: filterItems, 
                    icon: Icon(Icons.search))
                ],),
            ),
            SizedBox(height: 40,),
            Expanded(
              child:ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data[index].mes} ${data[index].fecha}",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("${data[index].diaSemana} ${data[index].hora}"),
                          const SizedBox(height: 10,),
                          Text(data[index].status=="AVAILABLE"?"Disponible":"Pendiente",style: TextStyle(color:data[index].status=="AVAILABLE"? Colors.green:Colors.red),)
                        ],
                      ),
                    ),
                    const SizedBox( width: 15,),
                    Expanded(
                      child:Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 20,bottom: 20,left: 40),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(24, 28, 120, 196),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index].placa,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(data[index].nit),
                            TextButton.icon(
                              onPressed:data[index].status=="AVAILABLE"? (){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewPdfScreen(inform: data[index].inform,)),
                                  );
                              }:null,
                              label:data[index].status=="AVAILABLE"? const Icon(Icons.arrow_forward,color: Colors.blue,): Icon(Icons.arrow_forward,color: Colors.blue[200],),
                              icon:data[index].status=="AVAILABLE"?const Text("Ver informe",style: TextStyle(color: Colors.blue),):Text("Ver informe",style: TextStyle(color: Colors.blue[200]),)
                            )
                          ],
                        ),
                      ),
                    )
                    ],
                );
            },
          )
           )
            ],
        ),
    );
  }
}
