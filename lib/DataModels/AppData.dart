/*
This contains all the offline app data shit (not user data) but app files 
*/
import './Tip.dart';
import './Mission.dart';

class AppData {
  static List<Tip> tips = [
    Tip(
        "Adopt the 2 minute rule",
        "If something can be done in two minutes, just do it!",
        "assets/tips/Just2It.png"),
    Tip(
        "Focus on small and fast wins",
        "Break your big goal down into tiny ones, it’ll help!! ",
        "assets/tips/BreakDownGoals.png"),
    Tip(
        "Don’t Break the Chain!",
        "Mark off the days you practice a habit you’re working on. Use the chain of marked off days as your motivation to keep the streak going",
        "assets/tips/Chain.png"),
    Tip(
        "Please stop multitasking :(",
        "It takes up more brain energy when you switch and change what you’re doing.",
        "assets/tips/Multitasking.png"),
    Tip(
        "You need an encourager",
        " Find someone you trust that will support you until you get the job done!",
        "assets/tips/Cheerleader.png"),
    Tip("Don’t be afraid to ask for help when you need it, alright?", "",
        "assets/tips/SOS.png"),
    Tip("Don't forget to take breaks!", "", "assets/tips/HaveABreak.png"),
    Tip(
        "Do the Pomodoro!",
        "Work for 25 minute blocks of time, with short 5 minute breaks, followed by longer breaks later on. This helps you eliminate interruptions and helps you estimate how long a certain task will take ",
        "assets/mission_icons/mission_icon_1.png"),
  ];
  static List<Mission> missions = [
    Mission(
        'mission_0',
        "Tomato Farmer",
        "Complete 10 tomatoes using the timer",
        'assets/mission_icons/mission_icon_1.png'),
    Mission('mission_1', "Orchard Owner", "Collect 10 apples",
        'assets/mission_icons/mission_icon_2.png'),
    Mission('mission_2', "Good Logger", "Keep logging in! Make progress!",
        'assets/mission_icons/mission_icon_3.png'),
    Mission('mission_3', "Picking Apple Pickers", "Add helpful friends",
        'assets/mission_icons/mission_icon_4.png'),
    Mission('mission_4', "Friendly Harvest", "Complete 10 group tasks",
        'assets/mission_icons/mission_icon_5.png'),
  ];

  static List<Reward> rewards = [
    Reward("Chill, Sweet Thing.", 'assets/tips/ChillSweetThing.png'),
    Reward("Fast Food Friends!", 'assets/tips/FastFoodFriends.png'),

    Reward("Have a Cookie!", 'assets/tips/HaveACookie.png'),

    Reward("Social Media Scroll!", 'assets/tips/SocialMediaScroll.png'),

    Reward("Take a Power Nap!", 'assets/tips/PowerNap.png'),

  ];
}

class Reward {

  String message;
  String imagePath;

  Reward(this.message, this.imagePath);
}
