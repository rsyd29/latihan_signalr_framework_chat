import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latihan_signalr_framework_chat/app/data/message.dart';
import 'package:signalr_flutter/signalr_flutter.dart';

class ChatController extends GetxController {
  late TextEditingController chatController;
  late SignalR signalR;

  var chatMessage = <MessageModel>[].obs;

  var statusConnection = ''.obs;

  final serviceUrl = 'http://192.168.1.71:8765/';
  final jsonEncoder = JsonEncoder();

  @override
  void onInit() {
    super.onInit();
    chatController = TextEditingController();
    startConnection();
  }

  Future<void> startConnection() async {
    await recreateConnection();
    print('Connection Started');
  }

  Future<void> recreateConnection() async {
    print('HomeController.startConnection');
    signalR = SignalR(
      serviceUrl,
      "ChatHub",
      hubMethods: ['addNewMessageToPage'],
      statusChangeCallback: (status) {
        print("statusChangeCallback: $status");
        statusConnection.value = status.toString();
      },
      hubCallback: _onNewMessage,
    );
    await signalR.connect();
  }

  _onNewMessage(String methodName, dynamic messageData) {
    // print('onNewMessage');
    print('MethodName = $methodName, Message = $messageData');
    print('MessageData Tipe Data: ${messageData.toString()}');

    final jsonDecode = JsonDecoder();

    Map<String, dynamic> data = jsonDecode.convert(messageData);

    var messageJsonData = {
      'Name': data['Name'],
      'Message': data['Message'],
    };
    chatMessage.add(MessageModel.fromJson(messageJsonData));
  }

  Future<void> sendMessage({required String messageData}) async {
    final res = await signalR.invokeMethod('Send', arguments: [
      messageData,
    ]).catchError((error) {
      print("Error invokeMethod: ${error.toString()}");
    }).then((value) {
      print("value: $value");
    });
    print("response: $res");

    chatController.clear();
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    chatController.dispose();
    signalR.stop();
    super.dispose();
  }
}
