class MessageModel {
  // String id;
  String name;
  String message;

  // String date;

  MessageModel({
    // required this.id,
    required this.name,
    required this.message,
    // required this.date,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      // id: json['id'],
      name: json['name'],
      message: json['message'],
      // date: json['date'],
    );
  }
}
