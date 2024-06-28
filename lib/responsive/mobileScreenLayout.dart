
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';


class mobileScreenLayout extends StatefulWidget {
  const mobileScreenLayout({super.key});

  @override
  State<mobileScreenLayout> createState() => _mobileScreenLayoutState();
}

class _mobileScreenLayoutState extends State<mobileScreenLayout> {
 
 int _pagevariable=0;
  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,color: _pagevariable==0?primaryColor:secondaryColor,),label: "",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.search,color: _pagevariable==1?primaryColor:secondaryColor,),label: "",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _pagevariable==2?primaryColor:secondaryColor,),label: "",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.favorite,color: _pagevariable==3?primaryColor:secondaryColor,),label: "",backgroundColor: primaryColor),
        BottomNavigationBarItem(icon: Icon(Icons.person,color: _pagevariable==4?primaryColor:secondaryColor,),label: "",backgroundColor: primaryColor)
      ],),
      body: Center(
        child: Text("mobile"),
      ),
    );
  }
}
