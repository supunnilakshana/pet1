import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet1/screens/components/constansts.dart';
import 'package:pet1/screens/welcom/wecomecreen_new.dart';
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
            primarySwatch: Colors.purple,
            primaryColor: kprimaryColor,
            focusColor: kprimaryColor,
            backgroundColor: Colors.white,
            textTheme: GoogleFonts.balsamiqSansTextTheme(
              Theme.of(context).textTheme,
            )),
        home: WelcomeScreenNew(),
      ));
}
