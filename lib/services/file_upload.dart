import 'dart:convert' show utf8;
import 'dart:io';
import 'dart:typed_data' show Uint8List;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';

class ImageUploader {
  static firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  static Future<String> uploadData(
      Uint8List data, String collection, String imgename) async {
    String downloadedData = "false";
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref(collection + '/' + imgename + '.png');

    try {
      await ref.putData(data);
      print("uploaded");

      downloadedData = await ref.getDownloadURL();

      print(downloadedData);
    } on Exception catch (e) {
      print(e.toString());
    }
    return downloadedData;
  }

  static Future<int> deletefile(String collection, String imgename) async {
    int a = 0;
    try {
      await storage.ref(collection + '/' + imgename + '.png').delete();
    } on Exception catch (e) {
      print(e.toString());
    }
    a = 1;
    return a;
  }

  // static Future<int> deletecollection(String collection) async {
  //   int a = 0;
  //   try {
  //     await storage.ref(collection).delete();
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  //   a = 1;
  //   return a;
  // }
}










// static Future<void> uploadFile(Uint8List filePath) async {
  //   // Uint8List imageInUnit8List = filePath; // store unit8List image here ;
  //   // final tempDir = await getTemporaryDirectory();
  //   File file = File.fromRawPath(filePath);
  //   //file.writeAsBytesSync(imageInUnit8List);
  //   //   print(file.path);
  //   firebase_storage.Reference ref =
  //       firebase_storage.FirebaseStorage.instance.ref('images/a.png');
  //   try {
  //     print("intry");
  //     await ref.putFile(file);
  //   } on FirebaseException catch (e) {
  //     print(e.toString());
  //   }
  // }