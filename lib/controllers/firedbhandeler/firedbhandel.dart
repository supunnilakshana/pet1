import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet1/controllers/firedbhandeler/user_handeler.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/petmodel.dart';

class FireDBHandeler {
  static final firestoreInstance = FirebaseFirestore.instance;
  static final user = FirebaseAuth.instance.currentUser;

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

    return list;
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
