import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();
  int counter = 0;
  void incrementCounter() {
    counter++;
    update();
  }
}
