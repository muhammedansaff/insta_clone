import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/resources/auth_method.dart';
import 'package:insta_clone/screens/login_screen.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:insta_clone/widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernametextcontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernametextcontroller.dispose();
  }

  void selectimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      username: _usernametextcontroller.text,
      bio: _biocontroller.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });

    print(res);
    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64),
                SvgPicture.asset(
                  "assets/images/ic_instagram.svg",
                  colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  height: 64,
                ),
                SizedBox(height: 64),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 65,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                AssetImage("assets/images/user.png"),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          selectimage();
                        },
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                MyTextField(
                  hint: "Enter Your Username",
                  textEditingController: _usernametextcontroller,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 25),
                MyTextField(
                  hint: "Enter Your Email",
                  textEditingController: _emailcontroller,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                MyTextField(
                  hint: "Enter Your Password",
                  textEditingController: _passwordcontroller,
                  textInputType: TextInputType.visiblePassword,
                  ispass: true,
                ),
                SizedBox(height: 24),
                MyTextField(
                  hint: "Enter Your bio",
                  textEditingController: _biocontroller,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    signUpUser();
                  },
                  child: Container(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text("Sign Up"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("already have an account?"),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        child: Text(
                          " Log In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                    SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
