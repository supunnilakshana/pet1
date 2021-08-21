import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet1/screens/login/loginscreen.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ));
}
