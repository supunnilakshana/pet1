import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/models/petmodel.dart';

class PetdbHandeler {
  final user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> adduser() async {
    firestoreInstance.collection("users").doc(user!.email.toString()).set({
      "email": user!.email.toString(),
    }).then((_) {
      print("success!");
    });
  }

  Future<void> addPet(Pet pet) async {
    String userpath = user!.email.toString();
    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(pet.name)
        .set({
      "name": pet.name,
      "type": pet.type,
      "age": pet.age,
      "species": pet.spec,
      "weight": pet.weight
    }).then((_) {
      print("success!");
    });
  }
}
