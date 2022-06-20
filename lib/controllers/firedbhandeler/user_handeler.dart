import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/models/log_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserdbHandeler {
  static final user = FirebaseAuth.instance.currentUser;
  static final firestoreInstance = FirebaseFirestore.instance;

//--------------------------------------add user----------------------------------------------------------------------------
  static Future<void> adduser() async {
    List<String> petlist = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = "";
    if (user!.providerData[0].providerId == 'google.com') {
      name = user!.displayName!;
    } else {
      name = prefs.getString('name') ?? " ";
    }
    firestoreInstance.collection("users").doc(user!.email.toString()).set({
      "email": user!.email.toString(),
      "pets": 0,
      "pet_list": petlist,
      "name": name
    }).then((_) {
      print("create user doc");
    });
  }

  //--------------------------------------get user pet list---------------------------------------------------------------------------
  static Future<List<String>> getPetlist() async {
    List<dynamic> pets = [];
    List<String> petlist = [];
    var firebaseUser = FirebaseAuth.instance.currentUser;
    int count = 0;
    await firestoreInstance
        .collection("users")
        .doc(firebaseUser!.email.toString())
        .get()
        .then((value) {
      print(value.data()!["pet_list"]);
      pets = value.data()!["pet_list"];
      pets.forEach((element) {
        petlist.add(element.toString());
      });
    });
    return petlist;
  }

  //--------------------------------------get user pet count----------------------------------------------------------------------------
  static Future userPetcount() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    int count = 0;
    await firestoreInstance
        .collection("users")
        .doc(firebaseUser!.email.toString())
        .get()
        .then((value) {
      print(value.data()!["pets"]);
      count = (value.data()!["pets"]);
      // print("----------------------------------------------------------------" +  count.toString());
    });
    return count;
  }

//--------------------------------------get user name----------------------------------------------------------------------------
  static Future<String> getuserName() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    String name = ' ';
    await firestoreInstance
        .collection("users")
        .doc(firebaseUser!.email.toString())
        .get()
        .then((value) {
      print(value.data()!["name"]);
      name = (value.data()!["name"]);
      // print("----------------------------------------------------------------" +  count.toString());
    });
    return name;
  }

  //--------------------------------------update user pet count----------------------------------------------------------------------------
  static Future updatePetcount() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    int count = await userPetcount();
    await firestoreInstance
        .collection("users")
        .doc(firebaseUser!.email.toString())
        .update({"pets": count + 1}).then((_) {
      print("success!");
    });
  }

  static Future updatePetlist(String name) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    List<String> currentlist = await getPetlist();
    currentlist.add(name);
    await firestoreInstance
        .collection("users")
        .doc(user!.email.toString())
        .update({"pet_list": currentlist}).then((_) {
      print("added");
    });
  }
}
