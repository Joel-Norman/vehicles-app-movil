import 'package:vehicle_app/app/aplication/ports/outputs/GenerateConsultPort.dart';
import 'package:vehicle_app/app/domain/GenerateConsult.dart';
import 'package:vehicle_app/app/infrastructure/adapters/outputs/GenerateConsultAdapter.dart';

class GenerateConsultController {
  late GenerateConsultPort portGenerate;

  GenerateConsultController() {
    portGenerate=GenerateConsultAdapter();
  }

  Future<GenerateConsult> generateConsult(GenerateConsult consult) async {
    return await portGenerate.generateConsult(consult);
  }
}