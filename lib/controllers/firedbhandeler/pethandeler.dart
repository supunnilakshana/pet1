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

  Future<List<Weight>> getweight(String docname) async {
    List<dynamic> weights = [];
    List<Weight> weightlist = [];

    String userpath = user!.email.toString();

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc("dulaj")
        .get()
        .then((value) {
      print("--------------------------------------------");
      weights = (value.data()!['weight']);
      weights.forEach((element) {
        Weight a = Weight.fromMap(element);
        weightlist.add(a);
      });

      // print(value.data()!['weight'][0]['date']);
    });
    return weightlist;
  }

  Future setWeight(String docname, Weight w) async {
    String userpath = user!.email.toString();
    List<dynamic> weights;

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      weights = (value.data()!['weight']);
      print("--------------------------");
      weights.add(w.toMap());
      print(weights.last);
      print(weights);
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"weight": weights}).then((_) {
        print("success!");
      });
    });
  }

  Future getBath(String docname) async {
    List<dynamic> baths;
    String userpath = user!.email.toString();

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");

      baths = value.data()!['bath'];
      print(baths.last.toString());
      return baths;
    });
  }

  Future setBath(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> baths;

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      baths = value.data()!['bath'];
      print(baths.last.toString());
      print("--------------------------");
      baths.add("2021.2.5");
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"bath": baths}).then((_) {
        print("success!");
      });
    });
  }
}
