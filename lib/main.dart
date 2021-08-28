import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet1/screens/add_pet/add_pet_screen.dart';
import 'package:pet1/screens/select_pet/selectpet_screen.dart';
import 'package:pet1/screens/welcom/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'controllers/authentication/google/GoogleSignAuth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Petzy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SelectPetscreen(),
      ));
}
