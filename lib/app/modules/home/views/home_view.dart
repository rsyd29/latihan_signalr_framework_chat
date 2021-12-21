import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_signalr_framework_chat/app/routes/app_pages.dart';
import 'package:latihan_signalr_framework_chat/constant.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latihan SignalR Framework Chat App',
              style: TextStyle(color: white),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextFormField(
                controller: controller.nameController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: 'What do people call you?',
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: 'Name *',
                  labelStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: blue),
                child: Text('Chat Room'),
                onPressed: () {
                  if (controller.nameController.text.trim().isNotEmpty) {
                    Get.toNamed(
                      Routes.CHAT,
                      arguments: controller.nameController.text,
                    )!
                        .then((_) => controller.nameController.clear());
                  } else {
                    Get.snackbar(
                      'Warning!',
                      'Please fill in the field form',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.amber,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
