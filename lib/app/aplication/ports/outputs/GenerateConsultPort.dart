
import 'package:vehicle_app/app/domain/GenerateConsult.dart';

abstract class GenerateConsultPort{
  Future<GenerateConsult> generateConsult(GenerateConsult consult);
}