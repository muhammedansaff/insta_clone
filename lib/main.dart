import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/responsive/mobileScreenLayout.dart';
import 'package:insta_clone/responsive/responsive.dart';
import 'package:insta_clone/responsive/webScreenLayout.dart';
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
      home: StreamBuilder(stream:  FirebaseAuth.instance.authStateChanges() ,
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.active){
          if(snapshot.hasData){
            return  ResponsiveLayout(
        mobileScreenLayout: mobileScreenLayout(),
         webScreenLayout: webScreenLayout(),
       );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),
            );


          }
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: primaryColor,),
          );
        }
        return LoginScreen();
      },
      )
    );
  }
}
