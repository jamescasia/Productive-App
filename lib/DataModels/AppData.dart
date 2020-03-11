
/*
This contains all the offline app data shit (not user data) but app files 
*/
import './Quote.dart';
import './Mission.dart'; 
class AppData{

  List<Quote> quotes = [
    Quote(0, "Marco Galo`", "Set the kitten wild free, It borns to be wild!"),
    Quote(1, "Mikko Geyrozaga", "Teach a man how to sit and he will sit for a day, Teach a man how to make a chair, and he will sit forever!"),

    
  ];
  List<Mission> missions=[
    Mission('mission_0', "Tomato Farmer", "Complete 10 tomatoes using the timer", 'assets/mission_icons/mission_icon_1.png' ),
    Mission('mission_1', "Orchard Owner", "Collect 10 apples", 'assets/mission_icons/mission_icon_2.png' ), 
    Mission('mission_2', "Good Logger", "Keep logging in! Make progress!", 'assets/mission_icons/mission_icon_3.png' ),
    Mission('mission_3', "Picking Apple Pickers", "Add helpful friends", 'assets/mission_icons/mission_icon_4.png' ),
    Mission('mission_4', "Friendly Harvest", "Complete 10 group tasks", 'assets/mission_icons/mission_icon_5.png' ),




  ];


}