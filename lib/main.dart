import 'package:center_manager/ui/nav/add_participant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CenterManagerApp());
}

class CenterManagerApp extends StatelessWidget {
  const CenterManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Center Manager',
      theme: ThemeData(
        // primaryColor: Colors.greenAccent,
        // primarySwatch: Colors.lightBlue,
        // primaryColorLight: Colors.white10,
        // primaryColorDark: Colors.black87,
        useMaterial3: true,
        fontFamily:
            GoogleFonts.comfortaa(fontWeight: FontWeight.bold).fontFamily,
      ),
      // home: const Home(),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: AddParticipant(),
      ),
    );
  }
}
