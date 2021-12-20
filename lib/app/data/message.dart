class MessageModel {
  // String id;
  String Name;
  String Message;

  // String date;

  MessageModel({
    // required this.id,
    required this.Name,
    required this.Message,
    // required this.date,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      // id: json['id'],
      Name: json['Name'],
      Message: json['Message'],
      // date: json['date'],
    );
  }
}
