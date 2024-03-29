class CollabTask {
  String id = "";
  bool completed = false;
  String deadline = "";
  bool archived = false;
  String title = "";
  double totalProgress = 0.0;
  List<CollabSubtask> collabSubtasks = [];

  CollabTask() {
    id = "";
    completed = false;
    deadline = "";
    title = "";
    totalProgress = 0.0;
    collabSubtasks = <CollabSubtask>[];
  }

  Map<String, dynamic> toJson() => {
        '"id"': '"$id"',
        '"title"': '"$title"',
        '"deadline"': '"$deadline"',
        '"completed"': completed,
        '"archived"': archived,
        '"totalProgress"': totalProgress,
        '"CollabSubtasks"': collabSubtasks.map((f) => f.toJson()).toList(),
      };

  factory CollabTask.fromJson(Map<String, dynamic> json) {
    var r = CollabTask();
    r.id = json["id"];
    r.title = json["title"];
    r.deadline = json["deadline"];
    r.completed = json["completed"];
    try {
      r.totalProgress = (json["totalProgress"]).toDouble();
    } catch (E) {}

    var list = json["CollabSubtasks"] as List;
    if (list == null) list = [];
    if (list.length > 0) {
      List<CollabSubtask> rList =
          list.map<CollabSubtask>((i) => CollabSubtask.fromJson(i)).toList();
      r.collabSubtasks = rList;
    } else
      r.collabSubtasks = <CollabSubtask>[];
    return r;
  }
}

class CollabSubtask {
  String id = "";
  bool completed = false;
  String title = "";
  String deadline = "";
  String assignedName = "";
  String assignedUid = "";

  CollabSubtask(this.id, this.title, this.deadline, this.assignedName,
      this.assignedUid, this.completed);
  Map<String, dynamic> toJson() => {
        '"id"': '"$id"',
        '"title"': '"$title"',
        '"deadline"': '"$deadline"',
        '"assignedName"': '"$assignedName"',
        '"assignedUid"': '"$assignedUid"',
        '"completed"': completed,
      };

  CollabSubtask.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        deadline = json["deadline"],
        assignedName = json["assignedName"],
        assignedUid = json["assignedUid"],
        completed = json["completed"];
}
