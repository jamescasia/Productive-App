class Stats {
  int numOfSoloTasksCompleted = 0;
  int numOfGroupTasksCompleted = 0;
  int numOfSubtasksCompleted = 0;
  int numOfGroupSubtasksCompleted = 0;
  int numOfPomodorosCompleted = 0;
  int numOfFriendsCollaboratedWith = 0;
  int numOfLoginsCompleted = 0;
  double percentageCompletedMissions = 0.0;
  List<bool> missionsCompleted = [false, false, false, false, false];
  List<String> missions = [
    '"tomatoFarmer"',
    '"orchardOwner"',
    '"goodLogger"',
    '"pickingApplePickers"',
    '"friendlyHarvest"',
  ];

  Stats() {}

  Map<String, dynamic> toJson() => {
        '"numOfSoloTasksCompleted"': numOfSoloTasksCompleted,
        '"numOfGroupTasksCompleted"': numOfGroupTasksCompleted,
        '"numOfSubtasksCompleted"': numOfSubtasksCompleted,
        '"numOfGroupSubtasksCompleted"': numOfGroupSubtasksCompleted,
        '"numOfPomodorosCompleted"': numOfPomodorosCompleted,
        '"numOfFriendsCollaboratedWith"': numOfFriendsCollaboratedWith,
        '"numOfLoginsCompleted"': numOfLoginsCompleted,
        '"percentageCompletedMissions"': percentageCompletedMissions,
        '"missionsCompleted"': missionsCompleted,
        '"missions"': missions,
      };

  update() {
    missionsCompleted[0] = numOfPomodorosCompleted >= 10;

    missionsCompleted[1] = numOfSoloTasksCompleted >= 10;

    missionsCompleted[2] = numOfLoginsCompleted >= 10;

    missionsCompleted[3] = numOfGroupTasksCompleted >= 10;

    missionsCompleted[4] = numOfFriendsCollaboratedWith >= 10;

    
  }

  // Stats.fromJson(Map<String, dynamic> json)
  //     : numOfSoloTasksCompleted = json["numOfSoloTasksCompleted"],
  //       numOfGroupTasksCompleted = json["numOfGroupTasksCompleted"],
  //       numOfSubtasksCompleted = json["numOfSubtasksCompleted"],
  //       numOfGroupSubtasksCompleted = json["numOfGroupSubtasksCompleted"],
  //       numOfPomodorosCompleted = json["numOfPomodorosCompleted"],
  //       numOfFriendsCollaboratedWith = json["numOfFriendsCollaboratedWith"],
  //       numOfLoginsCompleted = json["numOfLoginsCompleted"],
  //       percentageCompletedMissions =
  //           json["percentageCompletedMissions"].toDouble(),
  //       missionsCompleted = json["missionsCompleted"] as List<bool>,
  //       missions = json["missions"] as List<String>;

  factory Stats.fromJson(Map<String, dynamic> json) {
    var r = Stats();
    r.numOfSoloTasksCompleted = json["numOfSoloTasksCompleted"];
    r.numOfGroupTasksCompleted = json["numOfGroupTasksCompleted"];
    r.numOfSubtasksCompleted = json["numOfSubtasksCompleted"];
    r.numOfGroupSubtasksCompleted = json["numOfGroupSubtasksCompleted"];
    r.numOfPomodorosCompleted = json["numOfPomodorosCompleted"];
    r.numOfFriendsCollaboratedWith = json["numOfFriendsCollaboratedWith"];
    r.numOfLoginsCompleted = json["numOfLoginsCompleted"];
    try {
      r.percentageCompletedMissions =
          (json["percentageCompletedMissions"]).toDouble();
    } catch (E) {}

    var missions = json["missions"] as List;
    var missionsCompleted = json["missionsCompleted"] as List;
    missions = missions.map((i) => i.toString()).toList();
    missionsCompleted = missionsCompleted.map((i) => i).toList();

    return r;
  }
}
