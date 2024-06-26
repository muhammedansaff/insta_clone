
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/resources/auth_method.dart';
import 'package:insta_clone/responsive/mobileScreenLayout.dart';
import 'package:insta_clone/responsive/responsive.dart';
import 'package:insta_clone/responsive/webScreenLayout.dart';
import 'package:insta_clone/screens/home_screen.dart';
import 'package:insta_clone/screens/signup_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isloading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text,);
    if (res == "success") {
      print(res);
      Navigator.pushReplacement (context, MaterialPageRoute(builder: (context)=>ResponsiveLayout(
        mobileScreenLayout: mobileScreenLayout(),
         webScreenLayout: webScreenLayout(),
       )));
      showSnackBar("succesfully logged in", context);
      
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
              ),
              //svg image
              SvgPicture.asset(
                "assets/images/ic_instagram.svg",
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 64,
              ),
              SizedBox(
                height: 64,
              ),

              //textfirld input for email
              MyTextField(
                  hint: "Enter Your Email",
                  textEditingController: _emailcontroller,
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 24,
              ),
              //textfield for password
              MyTextField(
                hint: "Enter Your Password",
                textEditingController: _passwordcontroller,
                textInputType: TextInputType.visiblePassword,
                ispass: true,
              ),
              SizedBox(
                height: 24,
              ),
              //button login
              GestureDetector(
                onTap: () {
                  loginUser();
                },
                child: Container(
                  child: _isloading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("Log In"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                ),
              ),

              SizedBox(
                height: 50,
              ), //transition for signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an account? "),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Container(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
