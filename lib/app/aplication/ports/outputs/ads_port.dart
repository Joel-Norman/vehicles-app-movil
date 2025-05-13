import 'package:vehicle_app/app/domain/Ad.dart';

abstract class AdsPort{
  Future<List<Ad>> listAds();
}