import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamro_note_app/loginOrsignup/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    var useremail = emailController.text.trim();
    var userpassword = passwordController.text.trim();

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    if (useremail != "" && userpassword != "") {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: useremail, password: userpassword);
        Navigator.pop(context);
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
          content: Text("Please Fill up all the areas."),
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
              height: 450,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Login",
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
                  Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            border: InputBorder.none,
                            hintText: "Email"
                            // label: Text(
                            //   "Email",
                            //   style: GoogleFonts.abel(),
                            // ),
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password_outlined),
                            hintText: "Password",
                            // label: Text(
                            //   "Password",
                            //   style: GoogleFonts.abel(),
                            // ),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.abel(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: Size(350, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Forget Password?",
                      style: GoogleFonts.abel(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style:
                            GoogleFonts.abel(fontSize: 18, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Sign Up",
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
