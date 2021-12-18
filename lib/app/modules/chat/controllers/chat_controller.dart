import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latihan_signalr_framework_chat/app/data/message.dart';
import 'package:signalr_flutter/signalr_flutter.dart';

class ChatController extends GetxController {
  late TextEditingController chatController;
  late SignalR signalR;

  var chatMessage = <MessageModel>[].obs;

  var statusConnection = ''.obs;
  var connectionId = ''.obs;

  Future<void> startConnection() async {
    await recreateConnection();
    print('Connection Started');
  }

  Future recreateConnection() async {
    print('HomeController.startConnection');

    signalR = SignalR(
      'http://192.168.1.104:8321/',
      "ChatHub",
      hubMethods: ["addNewMessageToPage"],
      statusChangeCallback: (status) {
        print("statusChangeCallback: $status");
        statusConnection.value = status.toString();
      },
      hubCallback: (methodName, message) {
        print('MethodName = $methodName, Message = $message');
      },
    );

    await signalR.connect();
  }

  Future<void> sendMessage(
      {required String name, required String message}) async {
    var messageJson = {
      "id": signalR.connectionId,
      "name": name,
      "message": message,
      "date": DateTime.now().toIso8601String(),
    };

    await signalR.invokeMethod('Send', arguments: [
      name,
      message,
    ]).catchError((error) {
      print("Error invokeMethod: ${error.toString()}");
    });

    chatMessage.add(MessageModel.fromJson(messageJson));

    chatController.clear();
  }

  @override
  void onInit() {
    chatController = TextEditingController();
    startConnection();
    super.onInit();
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
