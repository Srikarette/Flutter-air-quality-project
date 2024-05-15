import 'package:core_libs/network/dio_service.dart';
import 'package:get_it/get_it.dart';
import '../network/http_services.dart';

final getIt = GetIt.instance;
const token = '2190be2f9c41f96905ba4fc092a664c0ad2d87b4';

void registerCoreServices() {
  getIt.registerSingleton<HttpService>(DioService('https://api.waqi.info/'));
}