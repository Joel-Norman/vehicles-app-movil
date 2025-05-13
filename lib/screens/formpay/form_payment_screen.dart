import 'package:flutter/material.dart';
import 'package:vehicle_app/app/domain/consult.dart';
import 'package:vehicle_app/app/domain/process_payment.dart';
import 'package:vehicle_app/app/domain/response_payment.dart';
import 'package:vehicle_app/controllers/GenerateConsultController.dart';
import 'package:vehicle_app/controllers/list_consult_controller.dart';
import 'package:vehicle_app/controllers/process_payment_controller.dart';
import 'package:vehicle_app/main.dart';
import 'package:vehicle_app/screens/view_pdf/view_pdf_screen.dart';
import 'package:vehicle_app/screens/web_view_screen/web_view_screen.dart';

class FormPaymentScreen extends StatefulWidget{
  final int id;
  const FormPaymentScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => FormPaymentScreenState(id: id);

}

class FormPaymentScreenState extends State<FormPaymentScreen>{
  final int id;
  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  ProcessPaymentController processController = ProcessPaymentController();
  
  FormPaymentScreenState({required this.id});

  GenerateConsultController generateController = GenerateConsultController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    

  }
  void processPayment(BuildContext context) async {
    try {
      PaymentInfo payment=PaymentInfo(
        billToAddress2: _address2Controller.text,
        billToCity: _cityController.text,
        billToAddress: _addressController.text,
        billToCountry: _cityController.text,
        billToEmail: _emailController.text,
        billToFirstName: _firstNameController.text,
        billToLastName: _lastNameController.text,
        billToState: _stateController.text,
        billToTelephone: _telephoneController.text,
        billToZipPostCode: _zipController.text,
      );
      ResponsePayment resp=  await processController.processPayment(payment,id);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: resp.url??"",)),
        );
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
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool required = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border:const UnderlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        ),
        validator: (value) {
          if (required && (value == null || value.isEmpty)) {
            return 'Es obligatorio';
          }
          return null;
        },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme:const IconThemeData(
          color: Colors.blue, // Cambia el color del ícono
        ),
        title:const Text("Formulario de pago",style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:const EdgeInsets.only(left: 40,right: 40),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nombres"),
                _buildTextField(label: '',controller: _firstNameController),
                const SizedBox(height: 20),
                const Text("Apellido"),
                _buildTextField(label: '',controller: _lastNameController),
                const SizedBox(height: 20),
                const Text("Domicilio"),
                _buildTextField(label: '',controller: _addressController),
                const SizedBox(height: 20),
                const Text("Domicilio alternativo"),
                _buildTextField(label: '',controller: _address2Controller),
                const SizedBox(height: 20),
                const Text("Ciudad"),
                _buildTextField(label: '',controller: _cityController),
                const SizedBox(height: 20),
                const Text("Estado"),
                _buildTextField(label: '',controller: _stateController),
                const SizedBox(height: 20),
                const Text("Codigo postal"),
                _buildTextField(label: '',controller: _zipController),
                const SizedBox(height: 20),
                const Text("Pais"),
                _buildTextField(label: '',controller: _countryController),
                const SizedBox(height: 20),
                const Text("Telefono"),
                _buildTextField(label: '',controller: _telephoneController, keyboardType: TextInputType.phone),
                const SizedBox(height: 20),
                const Text("Email"),
                _buildTextField(label: '',controller: _emailController, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      processPayment(context);
                    }
                  },
                  child: Text('Siguiente'),
                  )
                ),
                
              ],
            ),
            )
          ),
        ),
      ),

      );
  
  }
}
