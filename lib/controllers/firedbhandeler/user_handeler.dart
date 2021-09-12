import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/models/log_user.dart';

class UserdbHandeler {
  static final user = FirebaseAuth.instance.currentUser;
  static final firestoreInstance = FirebaseFirestore.instance;

//--------------------------------------add user----------------------------------------------------------------------------
  static Future<void> adduser() async {
    List<String> petlist = [];
    firestoreInstance.collection("users").doc(user!.email.toString()).set({
      "email": user!.email.toString(),
      "pets": 0,
      "pet_list": petlist
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

  //--------------------------------------update user pet count----------------------------------------------------------------------------
  static Future updatePetcount() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    int count = await userPetcount();
    firestoreInstance
        .collection("users")
        .doc(firebaseUser!.email.toString())
        .update({"pets": count + 1}).then((_) {
      print("success!");
    });
  }
}
