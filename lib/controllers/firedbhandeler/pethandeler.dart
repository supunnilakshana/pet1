import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/models/petmodel.dart';

class PetdbHandeler {
  final user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> adduser() async {
    firestoreInstance
        .collection("users")
        .doc(user!.email.toString())
        .set({"email": user!.email.toString(), "pets": 0}).then((_) {
      print("create user doc");
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
      "dob": pet.dob,
      "species": pet.spec,
      "gender": pet.gender,

      //"weight": pet.weight
    }).then((_) {
      print("success!");
    });
  }

  Future userPetcount() async {
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

  Future updarePetcount() async {
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
