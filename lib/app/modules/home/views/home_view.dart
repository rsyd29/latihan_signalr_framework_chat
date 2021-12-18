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
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: blue),
              child: Text('Chat Room'),
              onPressed: () => Get.toNamed(Routes.CHAT),
            ),
          ],
        ),
      ),
    );
  }
}
