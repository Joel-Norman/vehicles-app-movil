import 'package:vehicle_app/app/domain/consult.dart';

abstract class ListConsultPort{
  Future<List<Consult>> listConsult(String username);
}