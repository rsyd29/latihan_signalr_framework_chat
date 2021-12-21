import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:signalr_flutter/signalr_flutter.dart';

class HomeController extends GetxController {
  late TextEditingController nameController;

  @override
  void onInit() {
    nameController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.dispose();
  }
}
