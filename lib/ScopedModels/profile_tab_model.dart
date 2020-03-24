import 'package:scoped_model/scoped_model.dart'; 
import 'package:ProductiveApp/DataModels/AppData.dart';
class ProfileTabModel extends Model {

  double percentageCompletedMissions = 0.0;

  ProfileTabModel() {

  }

  updateProfilePercentageCompletedMissions(double val){
    this.percentageCompletedMissions = val;
    notifyListeners();
  }



}
