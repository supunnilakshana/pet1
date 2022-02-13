import 'package:pet1/controllers/models/pet_compents/pet_component.dart';
import 'package:pet1/controllers/models/pet_compents/pet_component.dart';

class Test1 {
  // static Future<EventModel> getEvent(String id) async {
  //     String userpath = user!.email.toString();
  //  final String collectionpath = "/users/" + userpath + "/event";
  //   EventModel model;

  //   DocumentSnapshot documentSnapshot =
  //       await firestoreInstance.collection(collectionpath).doc(id).get();
  //   model = EventModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  //   return model;
  // }

  // //update student
  // static Future<int> updateEvent(EventModel model) async {
  //     String userpath = user!.email.toString();
  //  final String collectionpath = "/users/" + userpath + "/event";
  //   int status = await checkdocstatus(collectionpath, model.id);
  //   if (status == 0) {
  //     firestoreInstance
  //         .collection(collectionpath)
  //         .doc(model.id)
  //         .update(model.toMap())
  //         .then((_) {
  //       print("update event doc");
  //     });
  //   } else {
  //     print(" no exits event");
  //   }
  //   return status;
  // }

  // static Future<List<EventModel>> getallEvents() async {
  //       String userpath = user!.email.toString();
  //  final String collectionpath = "/users/" + userpath + "/event";
  //   List<EventModel> list = [];
  //   EventModel EventModel;
  //   QuerySnapshot querySnapshot =
  //       await firestoreInstance.collection(collectionpath).get();
  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     // EventModel = EventModel.fromSnapshot(a);
  //     EventModel = EventModel.fromMap(a.data() as Map<String, dynamic>);
  //     list.add(EventModel);
  //     print(EventModel.id);
  //     //return studentslist;
  //   }

  //   return list;
  // }
}
