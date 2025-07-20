import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login3/homescreen.dart';
import 'package:login3/colors.dart';
import 'package:login3/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _email, _password;

  void registerUser() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.trim(), password: _password.trim());

      final uid = userCredential.user!.uid;
      print("User Registered. UID: $uid");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registration failed: $e"),
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
                      bgImage,
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
                    regitText,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    onSaved: (value) => _email = value!,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter your Email!";
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                        return "Invalid email format!";
                      }
                      return null;
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
                    onSaved: (value) => _password = value!,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "Enter your password";
                      } else if (password.length < 8) {
                        return "Password must be at least 8 characters!";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      prefixIcon: Icon(Icons.lock, color: primaryColor),
                      labelText: "PASSWORD",
                      labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: height * 0.08,
                    width: width - 40,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          registerUser();
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to login
                      },
                      child: Text("Login", style: TextStyle(color: primaryColor)),
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
