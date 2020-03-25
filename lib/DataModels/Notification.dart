class Notification {
  String time;
  String taskName;
  String message;
  Notification(this.taskName, this.time, this.message);

  Map<String, dynamic> toJson() => {
        '"taskName"': '"$taskName"',
        '"message"': '"$message"',
        '"time"': '"$time"',
      };

  Notification.fromJson(Map<String, dynamic> json)
      : taskName = json["taskName"],
        message = json["message"],
        time = json["time"];
}
