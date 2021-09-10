import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/controllers/validators/date.dart';

class PetdbHandeler {
  final user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

//--------------------------------------add user----------------------------------------------------------------------------
  Future<void> adduser() async {
    firestoreInstance
        .collection("users")
        .doc(user!.email.toString())
        .set({"email": user!.email.toString(), "pets": 0}).then((_) {
      print("create user doc");
    });
  }

//--------------------------------------add pet----------------------------------------------------------------------------
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
      "color": pet.color,
      "weights": pet.weight,
      "bath": pet.bath,
      "teeth": pet.teeth,
      "bath": pet.bath,
      "vaccines": pet.vaccines,
      "vitamins": pet.vitamins,
      "events": pet.events,

      //"weight": pet.weight
    }).then((_) {
      print("success!");
    });
  }

//--------------------------------------get user pet count----------------------------------------------------------------------------
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

//--------------------------------------update user pet count----------------------------------------------------------------------------
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

//--------------------------------------get a pet----------------------------------------------------------------------------
  Future getpet(String docname) async {
    Pet pet = Pet();
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("users").doc(docname).get().then((value) {
      pet.name = value.data()!["name"];
      var weight = value.data()!["weight"];
    });
  }

//--------------------------------------get pet weight----------------------------------------------------------------------------
  Future<List<Weight>> getweight(String docname) async {
    List<dynamic> weights = [];
    List<Weight> weightlist = [];

    String userpath = user!.email.toString();

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
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
    print(weights);
    return weightlist;
  }

//--------------------------------------set pet weight----------------------------------------------------------------------------
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
      // print(weights.last);
      print(weights);
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"weight": weights}).then((_) {
        print("success!");
      });
    });
  }

//--------------------------------------get pet bath----------------------------------------------------------------------------
  Future getBath(String docname) async {
    List<dynamic> bath;
    String userpath = user!.email.toString();

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");

      bath = value.data()!['baths'];
      print(bath.last.toString());
      return bath;
    });
  }

//--------------------------------------set pet bath----------------------------------------------------------------------------
  Future setBath(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> bath;

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      bath = value.data()!['baths'];
      // print(bath.last.toString());
      print("--------------------------");
      bath.add(Date.getStringdate());
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"baths": bath}).then((_) {
        print("success!");
      });
    });
  }

//--------------------------------------get pet hair----------------------------------------------------------------------------

  Future getHair(String docname) async {
    List<dynamic> hair;
    String userpath = user!.email.toString();

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");

      hair = value.data()!['hair'];
      print(hair.last.toString());
      return hair;
    });
  }

//--------------------------------------set pet hair----------------------------------------------------------------------------
  Future setHair(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> hair;

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      hair = value.data()!['hair'];
      //  print(hair.last.toString());
      print("--------------------------");
      hair.add(Date.getStringdate());
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"hair": hair}).then((_) {
        print("success!");
      });
    });
  }

//--------------------------------------get pet teeth----------------------------------------------------------------------------

  Future getTeeth(String docname) async {
    List<dynamic> teeth;
    String userpath = user!.email.toString();

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");

      teeth = value.data()!['teeth'];
      print(teeth.last.toString());
      return teeth;
    });
  }

//--------------------------------------get pet hair----------------------------------------------------------------------------
  Future setTeeth(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> teeth;

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      teeth = value.data()!['teeth'];
      // print(teeth.last.toString());
      print("--------------------------");
      teeth.add(Date.getStringdate());
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"teeth": teeth}).then((_) {
        print("success!");
      });
    });
  }
  //--------------------------------------set pet events----------------------------------------------------------------------------

  Future setEvents(String docname, List<dynamic> events) async {
    String userpath = user!.email.toString();

    firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .update({"weight": events}).then((_) {
      print("success!");
    });
  }
//--------------------------------------get pet events----------------------------------------------------------------------------

}
