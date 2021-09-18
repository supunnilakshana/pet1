import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/controllers/validators/date.dart';

class PetdbHandeler {
  final user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

//--------------------------------------add pet----------------------------------------------------------------------------
  Future<void> addPet(Pet pet) async {
    String userpath = user!.email.toString();
    List<String> petlist = [];

    await firestoreInstance
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
      "hair": pet.hair,
      "workout": pet.workout,
      "vaccines": pet.vaccines,
      "vitamins": pet.vitamins,
      "events": pet.events,

      //"weight": pet.weight
    }).then((_) async {
      petlist.add(pet.name);
      await firestoreInstance
          .collection("users")
          .doc(user!.email.toString())
          .update({"pet_list": petlist}).then((_) {
        print("added");
      });
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
      weights = (value.data()!['weights']);
      weights.forEach((element) {
        Weight a = Weight.fromMap(element);
        weightlist.add(a);
      });

      // print(value.data()!['weight'][0]['date']);
    });
    //   print(weights);

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
      weights = (value.data()!['weights']);
      print("--------------------------");
      weights.add(w.toMap());
      // print(weights.last);
      print(weights);
      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"weights": weights}).then((_) {
        print("success!");
      });
    });
  }

//--------------------------------------get pet bath----------------------------------------------------------------------------
  Future<List<String>> getBath(String docname) async {
    List<dynamic> bath;
    List<String> bathlist = [];
    String userpath = user!.email.toString();

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) async {
      bath = await value.data()!['bath'];
      print("-----------------------|||||||||||||--------------");

      print(bath);

      bath.forEach((element) {
        bathlist.add(element.toString());
      });
    });
    return bathlist;
  }

//--------------------------------------set pet bath----------------------------------------------------------------------------
  Future setBath(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> bath = [];

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) async {
      bath = await value.data()!['bath'];

      bath.add(Date.getStringdate());

      // print(bath.last.toString());
      print("--------------------------");

      firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"bath": bath}).then((_) {
        print("success!");
      });
    });
  }

//--------------------------------------get pet hair----------------------------------------------------------------------------

  Future<List<String>> getHair(String docname) async {
    List<dynamic> hair;
    List<String> list = [];
    String userpath = user!.email.toString();

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");

      hair = value.data()!['hair'];
      hair.forEach((element) {
        list.add(element.toString());
      });
    });
    return list;
  }

//--------------------------------------set pet hair----------------------------------------------------------------------------
  Future setHair(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> hair;

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) async {
      hair = value.data()!['hair'];
      //  print(hair.last.toString());
      print("--------------------------");
      hair.add(Date.getStringdate());
      await firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"hair": hair}).then((_) {
        print("success!");
      });
    });
  }

//--------------------------------------get pet teeth----------------------------------------------------------------------------

  Future<List<String>> getTeeth(String docname) async {
    List<dynamic> teeth;
    List<String> list = [];
    String userpath = user!.email.toString();

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");

      teeth = value.data()!['teeth'];
      // print(teeth.last.toString());
      teeth.forEach((element) {
        list.add(element.toString());
      });
    });

    return list;
  }

//--------------------------------------set pet teeth----------------------------------------------------------------------------
  Future setTeeth(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> teeth;

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) async {
      teeth = value.data()!['teeth'];
      // print(teeth.last.toString());
      print("--------------------------");
      teeth.add(Date.getStringdate());
      await firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"teeth": teeth}).then((_) {
        print("success!");
      });
    });
  }

//--------------------------------------get pet workout----------------------------------------------------------------------------

  Future<List<String>> getWorkout(String docname) async {
    List<dynamic> workout;
    List<String> list = [];
    String userpath = user!.email.toString();

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");

      workout = value.data()!['workout'];
      // print(teeth.last.toString());
      workout.forEach((element) {
        list.add(element.toString());
      });
    });

    return list;
  }

//--------------------------------------set pet workout----------------------------------------------------------------------------
  Future setWorkout(String docname) async {
    String userpath = user!.email.toString();
    List<dynamic> workout;

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) async {
      workout = value.data()!['workout'];
      // print(teeth.last.toString());
      print("--------------------------");
      workout.add(Date.getStringdate());
      await firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(docname)
          .update({"workout": workout}).then((_) {
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
  Future<List<Event>> getEvents(String docname) async {
    List<dynamic> events = [];
    List<Event> eventlist = [];

    String userpath = user!.email.toString();

    await firestoreInstance
        .collection("/users/" + userpath + "/pet")
        .doc(docname)
        .get()
        .then((value) {
      print("--------------------------------------------");
      events = (value.data()!['events']);
      events.forEach((element) {
        Event a = Event.fromMap(element);
        eventlist.add(a);
      });

      // print(value.data()!['weight'][0]['date']);
    });
    print(events);
    return eventlist;
  }
}


/*

//--------------------------------------add user----------------------------------------------------------------------------
  Future<void> adduser() async {
    List<String> petlist = [];
    firestoreInstance.collection("users").doc(user!.email.toString()).set({
      "email": user!.email.toString(),
      "pets": 0,
      "pet_list": petlist
    }).then((_) {
      print("create user doc");
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




*/