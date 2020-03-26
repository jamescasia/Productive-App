class CollabNotification {
  String time;
  String taskName;
  String message;
  CollabNotification(this.taskName, this.time, this.message);

  Map<String, dynamic> toJson() => {
        '"taskName"': '"$taskName"',
        '"message"': '"$message"',
        '"time"': '"$time"',
      };

  CollabNotification.fromJson(Map<String, dynamic> json)
      : taskName = json["taskName"],
        message = json["message"],
        time = json["time"];
}
