// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamro_note_app/features/loginOrsignup/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpassController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  void _signup() async {
    var userEmail =
        emailController.text.trim(); //trim will trim any extra spaces used
    var userPassword = passwordController.text.trim();
    var confirmPassword = confpassController.text.trim();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (userEmail != '' && userPassword != '' && confirmPassword != '') {
      try {
        if (userPassword == confirmPassword) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: userEmail, password: userPassword);
          Navigator.pop(context);
          // .then((value) => {
          //       FirebaseFirestore.instance.collection('users').doc().set({
          //         "userEmail": userEmail,
          //         "userPassword": userPassword,
          //         "createdAt": DateTime.now(),
          //         "currentUser": currentUser!.uid,
          //       })
          //     });
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password Donot Match!"),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill up all the areas!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          //Background Image
          Container(
            height: size.height,
            width: size.width,
            child: Image.asset(
              "assets/images/NotePaper.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Container(
              height: size.height * 0.60,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "SignUp",
                    style: GoogleFonts.abel(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                      obscureText: false,
                      tcontroller: emailController,
                      hintText: "Email ",
                      prefixIcon: Icon(Icons.email_outlined)),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                      obscureText: true,
                      tcontroller: passwordController,
                      hintText: " Password",
                      prefixIcon: Icon(Icons.password_outlined)),
                  SizedBox(
                    height: 10,
                  ),
                  InputTextField(
                      obscureText: true,
                      tcontroller: confpassController,
                      hintText: "Confirm Password",
                      prefixIcon: Icon(Icons.password_outlined)),
                  SizedBox(
                    height: 20,
                  ),
                  Button(
                    onPressed: () {
                      _signup();
                    },
                    name: "SignUp",
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style:
                            GoogleFonts.abel(fontSize: 18, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Log in",
                          style: GoogleFonts.abel(
                              color: Colors.blue, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final TextEditingController tcontroller;
  final Icon prefixIcon;
  final String hintText;
  final bool obscureText;
  const InputTextField(
      {super.key,
      required this.tcontroller,
      required this.hintText,
      required this.prefixIcon,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
          border: Border.all(color: Colors.white)),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          controller: tcontroller,
          obscureText: obscureText,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hintText,
              // label: Text("Confirm Password"),
              border: InputBorder.none),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  const Button({super.key, required this.onPressed, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        name,
        style: GoogleFonts.abel(color: Colors.white, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          fixedSize: Size(350, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    );
  }
}
