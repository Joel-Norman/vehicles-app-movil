
import 'dart:async';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_app/app/aplication/api/host.dart';
import 'package:vehicle_app/controllers/RegisterController.dart';

class ViewPdfScreen extends StatefulWidget{
  final String inform;
  const ViewPdfScreen({super.key,required this.inform});

  @override
  State<StatefulWidget> createState() => ViewPdfScreenState(inform);

}

class ViewPdfScreenState extends State<ViewPdfScreen>{
  final String inform;
  bool _isLoading=true;
  late PDFDocument doc;
  RegisterController registerController = RegisterController();
String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";
 ViewPdfScreenState(this.inform);

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl(context);
    /*try {
      createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    }).catchError((onError){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 100, left: 16, right: 16),
          content: Text("$onError")),
      );
    });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 200, left: 16, right: 16),
          content: Text("$e")),
      );
      print("$e");
    }
    */
  }

  Future<void> createFileOfPdfUrl(BuildContext context) async {
    try {
      final url = urlApi+"/inform/"+inform;
      
      doc = await PDFDocument.fromURL(url);
      setState(() {
        _isLoading=false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 14000),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 200, left: 16, right: 16),
          content: Text("$e")),
          
      );
    }
    
      
    /*Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      print("Download files1");
      final filename = url.substring(url.lastIndexOf("/") + 1);
      print("Download files2");
      var request = await HttpClient().getUrl(Uri.parse(url));
      print("Download files3");
      var response = await request.close();
      print("Download files4");
      var bytes = await consolidateHttpClientResponseBytes(response);
      print("Download files5");
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 50, left: 16, right: 16),
          content: Text("$e")),
      );
      throw Exception('Error parsing asset file!');
    }

    return completer.future;*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informe del vehiculo'),
      ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: doc)),
    );
  }
}