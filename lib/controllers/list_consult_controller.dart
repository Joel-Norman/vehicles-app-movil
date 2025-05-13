import 'package:vehicle_app/app/aplication/ports/outputs/list_consult_port.dart';
import 'package:vehicle_app/app/domain/consult.dart';
import 'package:vehicle_app/app/infrastructure/adapters/outputs/list_consult_adapter.dart';

class ListConsultController {
  late ListConsultPort portList;

  ListConsultController() {
    portList=ListConsultAdapter();
  }

  Future<List<Consult>> listConsult(String username) async {
    return await portList.listConsult(username);
  }
}