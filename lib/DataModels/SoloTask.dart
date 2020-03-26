class SoloTask {
  String id = "";
  bool completed = false;
  bool archived = false;
  String deadline = "";
  String title = "";
  double totalProgress = 0.0;
  List<Subtask> subtasks = [];

  SoloTask() {
    id = "";
    completed = false;
    deadline = "";
    title = "";
    totalProgress = 0.0;
    subtasks = <Subtask>[];
  }

  Map<String, dynamic> toJson() => {
        '"id"': '"$id"',
        '"title"': '"$title"',
        '"deadline"': '"$deadline"',
        '"completed"': completed,
        '"archived"': archived,
        '"totalProgress"': totalProgress,
        '"subtasks"': subtasks.map((f) => f.toJson()).toList(),
      };

  factory SoloTask.fromJson(Map<String, dynamic> json) {
    var r = SoloTask();
    r.id = json["id"];
    r.title = json["title"];
    r.deadline = json["deadline"];
    r.completed = json["completed"];
    try {
      r.totalProgress = (json["totalProgress"]).toDouble();
    } catch (E) {}

    var list = json["subtasks"] as List;
    if(list == null) list = [];
    if (list.length > 0) {
      List<Subtask> rList =
          list.map<Subtask>((i) => Subtask.fromJson(i)).toList();
      r.subtasks = rList;
    } else
      r.subtasks = <Subtask>[];
    return r;
  }
}

class Subtask {
  String id = "";
  bool completed = false;
  String title = "";
  String deadline = "";

  Subtask(this.id, this.title, this.deadline, this.completed);
  Map<String, dynamic> toJson() => {
        '"id"': '"$id"',
        '"title"': '"$title"',
        '"deadline"': '"$deadline"',
        '"completed"': completed,
      };

  Subtask.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        deadline = json["deadline"],
        completed = json["completed"];
}
