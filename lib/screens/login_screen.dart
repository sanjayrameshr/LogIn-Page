import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login3/screens/home_screen.dart';
import 'package:login3/widgets/constants_values.dart';
import 'package:login3/widgets/colors.dart';
import 'package:login3/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void signIn() async {
    // 1. Validate the form fields
    if (formKey.currentState!.validate()) {
      // 2. Save the field values to the variables
      formKey.currentState!.save();

      // 3. Show a loading indicator for better UX
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator(color: primaryColor));
        },
      );

      try {
        // 4. Use the variables to sign in with Firebase
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // 5. If successful, close the loading dialog and navigate
        if (mounted) {
          Navigator.pop(context); // Close dialog
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Close the loading dialog before showing an error
        if (mounted) Navigator.pop(context);

        // 6. Show specific error messages to the user
        String errorMessage = "An error occurred. Please try again.";
        if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
          errorMessage = "No user found for that email. Please check your email or create an account.";
        } else if (e.code == 'wrong-password') {
          errorMessage = "Wrong password provided for that user.";
        }
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ));
      }
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
                      // Error handling for the image asset
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: height * 0.40,
                          width: width,
                          color: Colors.grey[200],
                          child: const Center(child: Text('Image not found')),
                        );
                      },
                    ),
                    Container(
                      height: height * 0.40,
                      width: width,
                      decoration: const BoxDecoration(
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
                const Center(
                  child: Text(
                    appName,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                ),
                const Center(
                    child: Text(slogan, style: TextStyle(color: Colors.grey))),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withOpacity(0.1),
                          Colors.transparent
                        ],
                      ),
                      border: const Border(left: BorderSide(color: primaryColor, width: 5)),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter your Email!";
                      } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
                        return "Please enter a valid email!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      prefixIcon: Icon(Icons.email, color: primaryColor),
                      labelText: "EMAIL ADDRESS",
                      labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return "Please enter your password";
                      } else if (password.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                      prefixIcon: Icon(Icons.lock_open, color: primaryColor),
                      labelText: "PASSWORD",
                      labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(onPressed: () {}, child: const Text("Forgot password?", style: TextStyle(color: primaryColor))),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: height * 0.06,
                    width: width - 40,
                    child: ElevatedButton( 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      onPressed: () {
                        signIn();
                      },
                      child: const Text(
                        "Login to Account",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: const Text(
                        "Create account",
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
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
