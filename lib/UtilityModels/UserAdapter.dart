
import './GroupTaskAdapter.dart';
import './SoloTaskAdapter.dart';
import 'package:ProductiveApp/DataModels/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
class UserAdapter { 


  GroupTaskAdapter groupTaskAdapter;
  User user;
  String uid;
  FirebaseUser fUser;
  GoogleSignInAccount gUser;


  UserAdapter(){
    groupTaskAdapter = GroupTaskAdapter();
    user = User();
      

  }




  







}