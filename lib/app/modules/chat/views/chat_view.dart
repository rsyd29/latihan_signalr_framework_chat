import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:latihan_signalr_framework_chat/constant.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: blue,
        title: Text('Chat Room'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Connection Status:\n${controller.statusConnection}',
                    style: TextStyle(
                      fontSize: 14,
                      color: white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.chatMessage.length,
                  itemBuilder: (context, index) {
                    var currentItem = controller.chatMessage[index];
                    return MessageItem(
                      key: key,
                      // sentByMe:
                      //     currentItem.id == controller.signalR.connectionId,
                      name: currentItem.name,
                      message: currentItem.message,
                      // date: currentItem.date,
                    );
                  },
                );
              }),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: blue,
                  controller: controller.chatController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          if (controller.chatController.text.isNotEmpty) {
                            await controller.sendMessage(
                              name: "B",
                              message: controller.chatController.text.trim(),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    // required this.sentByMe,
    required this.message,
    // required this.date,
    required this.name,
  }) : super(key: key);

  // final bool sentByMe;
  final String message;

  // final String date;
  final String name;

  @override
  Widget build(BuildContext context) {
    // var parseDate = DateTime.parse(date);
    return Align(
      // alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          // color: sentByMe ? blue : white,
          color: white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              name + ": ",
              style: TextStyle(
                fontSize: 14,
                // color: sentByMe ? white : blue,
                color: blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                // color: (sentByMe ? white : blue).withOpacity(0.7),
                color: blue.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
