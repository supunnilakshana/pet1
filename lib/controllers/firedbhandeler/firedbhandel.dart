import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/firedbhandeler/user_handeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';
import 'package:pet1/controllers/validators/date.dart';

class FireDBHandeler {
  static final firestoreInstance = FirebaseFirestore.instance;
  static final user = FirebaseAuth.instance.currentUser;
  static String MainUserpath = "/users/" + user!.email.toString() + "/";

//check doc is exists
  static Future<int> checkdocstatus(String collectionpath, String docid) async {
    var a = await FirebaseFirestore.instance
        .collection(collectionpath)
        .doc(docid)
        .get();
    if (a.exists) {
      print('Exists');
      return 0;
    } else if (!a.exists) {
      print('Not exists');
      return 1;
    } else {
      return 2;
    }
  }

// register pet
  static Future<int> addPet(Pet pet) async {
    String userpath = user!.email.toString();
    int status = await checkdocstatus("/users/" + userpath + "/pet", pet.name);
    if (status == 1) {
      await firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(pet.name)
          .set(pet.toMap())
          .then((_) async {
        await UserdbHandeler.updatePetlist(pet.name);
        await UserdbHandeler.updatePetcount();
        print("create pet doc");
      });
    } else {
      print(" pet name all ready exsists");
    }
    return status;
  }

  // register pet
  static Future<int> updatePet(Pet pet) async {
    String userpath = user!.email.toString();
    int status = await checkdocstatus("/users/" + userpath + "/pet", pet.name);
    if (status == 0) {
      await firestoreInstance
          .collection("/users/" + userpath + "/pet")
          .doc(pet.name)
          .update(pet.toMap())
          .then((_) async {
        await UserdbHandeler.updatePetlist(pet.name);
        await UserdbHandeler.updatePetcount();
        print("update pet doc");
      });
    } else {
      print(" pet name not exsists");
    }
    return status;
  }

  //get all pet

  static Future<List<Pet>> getallPets() async {
    String userpath = user!.email.toString();
    final String collectionpath = "/users/" + userpath + "/pet";
    List<Pet> list = [];
    Pet petModel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionpath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      // EventModel = EventModel.fromSnapshot(a);
      petModel = Pet.fromMap(a.data() as Map<String, dynamic>);
      list.add(petModel);
      print(petModel.id);
      //return list;
    }

    return list;
  }

//---------------------------------------events-----------------------------------------
  static Future<int> addEvent(EventModel model) async {
    String userpath = user!.email.toString();
    final String collectionpath = "/users/" + userpath + "/event";
    int status = await checkdocstatus(collectionpath, model.id);
    if (status == 1) {
      await firestoreInstance
          .collection(collectionpath)
          .doc(model.id)
          .set(model.toMap())
          .then((_) {
        print("create event doc");
      });
    } else {
      print(" this event all ready exsists");
    }
    return status;
  }

  static Future<EventModel> getEvent(String id) async {
    String userpath = user!.email.toString();
    final String collectionpath = "/users/" + userpath + "/event";
    EventModel model;

    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection(collectionpath).doc(id).get();
    model = EventModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return model;
  }

  //update event
  static Future<int> updateEvent(EventModel model) async {
    String userpath = user!.email.toString();
    final String collectionpath = "/users/" + userpath + "/event";
    int status = await checkdocstatus(collectionpath, model.id);
    if (status == 0) {
      firestoreInstance
          .collection(collectionpath)
          .doc(model.id)
          .update(model.toMap())
          .then((_) {
        print("update event doc");
      });
    } else {
      print(" no exits event");
    }
    return status;
  }

  static Future<List<EventModel>> getallEvents() async {
    String userpath = user!.email.toString();
    final String collectionpath = "/users/" + userpath + "/event";
    List<EventModel> list = [];
    EventModel eventModel;
    QuerySnapshot querySnapshot =
        await firestoreInstance.collection(collectionpath).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      // EventModel = EventModel.fromSnapshot(a);
      eventModel = EventModel.fromMap(a.data() as Map<String, dynamic>);
      list.add(eventModel);
      print(eventModel.id);
      //return list;
    }

    list.sort((a, b) => b.id.compareTo(a.id));

    return list;
  }

//day activity
  static initDayactivity(String petname) async {
    PetDayActivity model =
        PetDayActivity(bath: [], hair: [], teeth: [], workout: []);
    String userpath = user!.email.toString();
    final String collectionpath =
        "/users/" + userpath + "/pet/" + petname + "/activities";

    await firestoreInstance
        .collection(collectionpath)
        .doc("dayactivity")
        .set(model.toMap())
        .then((_) {
      print("create pet day activity doc");
    });
  }

  static Future<PetDayActivity> getdayActivity(String petname) async {
    String userpath = user!.email.toString();
    final String collectionpath =
        "/users/" + userpath + "/pet/" + petname + "/activities";
    PetDayActivity model;
    DocumentSnapshot documentSnapshot = await firestoreInstance
        .collection(collectionpath)
        .doc("dayactivity")
        .get();
    model =
        PetDayActivity.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return model;
  }

  static Future<int> updatedayActivity(
      String activityley, String petname) async {
    int res = 0;
    String userpath = user!.email.toString();
    final String collectionpath =
        "/users/" + userpath + "/pet/" + petname + "/activities";
    List<dynamic> datalist;

    await firestoreInstance
        .collection(collectionpath)
        .doc("dayactivity")
        .get()
        .then((value) async {
      datalist = value.data()![activityley];
      // print(teeth.last.toString());
      print("--------------------------");
      datalist.add(Date.getStringdate());
      await firestoreInstance
          .collection(collectionpath)
          .doc("dayactivity")
          .update({activityley: datalist}).then((_) {
        res = 1;
        print("success!");
      });
    });

    return res;
  }

//weight

  static initweightDoc(String petname) async {
    List<dynamic> initlist = [];
    String userpath = user!.email.toString();
    final String collectionpath =
        "/users/" + userpath + "/pet/" + petname + "/petfundata";

    await firestoreInstance
        .collection(collectionpath)
        .doc("weight")
        .set({"weights": initlist}).then((_) {
      print("create pet day weight doc");
    });
  }

  static Future<int> updateWeight(String petname, Weight data) async {
    int res = 0;
    String userpath = user!.email.toString();
    final String collectionpath =
        "/users/" + userpath + "/pet/" + petname + "/petfundata";

    List<dynamic> datalist = [];
    print("okkkkkkkkkkkkkkkkkk");
    await firestoreInstance
        .collection(collectionpath)
        .doc("weight")
        .get()
        .then((value) async {
      datalist = value.data()!["weights"];

      print("--------------------------");
      datalist.add(data.toMap());
      await firestoreInstance
          .collection(collectionpath)
          .doc("weight")
          .update({"weights": datalist}).then((_) {
        res = 1;
        print("success!");
      });
    });

    return res;
  }

  static Future<int> updateWeightlist(
      String petname, List<Weight> weightlist) async {
    int res = 0;
    String userpath = user!.email.toString();
    final String collectionpath =
        "/users/" + userpath + "/pet/" + petname + "/petfundata";

    try {
      List<dynamic> datalist = [];
      print("okkkkkkkkkkkkkkkkkk");

      weightlist.forEach((element) {
        datalist.add(element.toMap());
      });

      await firestoreInstance
          .collection(collectionpath)
          .doc("weight")
          .update({"weights": datalist}).then((_) {
        res = 1;
        print("success!");
      });
    } on Exception catch (e) {
      print(e);
    }

    return res;
  }

  static Future<List<Weight>> geteWeight(String petname) async {
    int res = 0;
    String userpath = user!.email.toString();
    final String collectionpath =
        "/users/" + userpath + "/pet/" + petname + "/petfundata";

    List<dynamic> datalist = [];
    List<Weight> restrunlist = [];

    await firestoreInstance
        .collection(collectionpath)
        .doc("weight")
        .get()
        .then((value) async {
      datalist = value.data()!["weights"];

      datalist.forEach((element) {
        restrunlist.add(Weight.fromMap(element));
      });
      print("--------------------------");
    });

    return restrunlist;
  }
  //delete doc

//delete document
  static Future<int> deletedoc(String id, String collection) async {
    int ishere = await checkdocstatus(collection, id);
    if (ishere == 0) {
      await firestoreInstance.collection(collection).doc(id).delete();
    }
    return ishere;
  }
}
