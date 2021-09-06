import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
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

  Future getpet(String docname) async {
    Pet pet = Pet();
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("users").doc(docname).get().then((value) {
      pet.name = value.data()!["name"];
      var weight = value.data()!["weight"];
    });
  }

  Future getweight(String docname) async {
    Weight weight;
    String userpath = user!.email.toString();

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc("dulaj")
        .get()
        .then((value) {
      print("--------------------------------------------");
      weight = Weight.fromMap(value.data()!['weight'][1]);
      // print(value.data()!['weight'][0]['date']);
      print(weight.dateTime);
    });
  }

  Future setweight(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> weights;

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc("dulaj")
        .get()
        .then((value) {
      weights = (value.data()!['weights']);
      Weight neww = Weight("super", 30);
      print("--------------------------");

      weights.add(neww.toMap());

      print(weights);
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc("dulaj")
          .set({"weights": weights}).then((_) {
        print("success!");
      });
    });
  }
}
