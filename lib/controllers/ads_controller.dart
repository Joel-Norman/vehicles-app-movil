import 'package:vehicle_app/app/aplication/ports/outputs/ads_port.dart';
import 'package:vehicle_app/app/domain/Ad.dart';
import 'package:vehicle_app/app/infrastructure/adapters/outputs/ads_adapter.dart';

class AdsController {
  late AdsPort portAds;

  AdsController() {
    portAds=AdsAdapter();
  }

  Future<List<Ad>> listAds() async {
    return await portAds.listAds();
  }
}