import 'package:core_libs/dependency_injection/get_it.dart';
import 'package:product/infrasturcture/dependency_injection/injector.dart';

void registerServices() {
  registerCoreServices();
  registerProductServices();
}