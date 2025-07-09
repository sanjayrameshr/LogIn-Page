import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login3/homescreen.dart';
import 'package:login3/constants.dart'; 
import 'package:login3/colors.dart';
import 'package:login3/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _email, _password;

  void signIn() async {
    if (_email =="sanjayramesh957@gmail.com"  && _password == "sara@123" ){
      // Simulate a login
      print("Login successful for test user!");
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((authuser) {
        print("UID: ${authuser.user!.uid}");
        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homescreen()),
        );
      }).catchError((onError) {
        print(onError);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Login failed. Please check your credentials."),
          backgroundColor: Colors.red,
        ));
      });
    } else {
      print("Invalid login details!");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid login details. Please check your email or password."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      bgImage, // Add your background image
                      height: height * 0.40,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height * 0.40,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0.3, 0.8],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.white],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    appName, 
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ),
                Center(
                child: Text(slogan, style: TextStyle( color: Colors.grey))),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.3),
                          Colors.transparent
                        ],
                      ),
                      border: Border(left: BorderSide(color: primaryColor, width: 5)),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter your Email!";
                      } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
                        return "Check your Email!";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      prefixIcon: Icon(Icons.email, color: primaryColor),
                      labelText: "EMAIL ADDRESS",
                      labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "Enter your password";
                      } else if (password.length < 8) {
                        return "Enter correct password!";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      prefixIcon: Icon(Icons.lock_open, color: primaryColor),
                      labelText: "PASSWORD",
                      labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () {}, child: Text("Forgot password?", style: TextStyle(color: primaryColor), )),
                ),
                Center(
                  child: SizedBox(
                    height: height * 0.08,
                    width: width - 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Homescreen()));
                        if (formKey.currentState?.validate() == true) {
                          formKey.currentState!.save();
                          signIn(); // Call signIn when the form is valid
                        }
                      },
                      child: Text(
                        "Login to Account!",
                        style: TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()), );
                      },
                      child: Text(
                        "Create account",
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
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
