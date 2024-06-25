import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCqmP8wit_oD4B09fzn7lXh6gObR96FSvw",
        appId: "1:1039546082795:web:4d1999a407bc8f100065ae",
        messagingSenderId: "1039546082795",
        projectId: "instaclone-badb4",
        storageBucket: "instaclone-badb4.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "insta_clone",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: ResponsiveLayout(
      //   mobileScreenLayout: mobileScreenLayout(),
      //   webScreenLayout: webScreenLayout(),
      // ),
      home: LoginScreen(),
    );
  }
}
