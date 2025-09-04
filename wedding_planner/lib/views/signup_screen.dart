import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/models/snack_bar_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hidePassword = true;
  bool isAgree = false;
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 247, 1),
      body: Stack(
        children: [
          Positioned(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 75),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 75),
                    Text(
                      "Create Account",
                      style: GoogleFonts.secularOne(
                        fontWeight: FontWeight.w400,
                        fontSize:
                            MediaQuery.of(context).size.width * 0.1071428571,
                        color: const Color.fromRGBO(228, 26, 94, 1),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: GoogleFonts.secularOne(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.0357142857,
                            color: const Color.fromARGB(255, 235, 37, 103),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: emailController,
                          style: GoogleFonts.secularOne(
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.0357142857,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(181, 0, 60, 1),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(228, 26, 94, 0.5),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(228, 26, 94, 0.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.secularOne(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.0357142857,
                            color: const Color.fromARGB(255, 235, 37, 103),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          style: GoogleFonts.secularOne(
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.0357142857,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIconColor: Colors.white,
                            suffixIcon:
                                (hidePassword)
                                    ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      child: const Icon(Icons.visibility_off),
                                    )
                                    : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      child: const Icon(Icons.visibility),
                                    ),
                            filled: true,
                            fillColor: const Color.fromRGBO(181, 0, 60, 1),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(228, 26, 94, 0.5),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(228, 26, 94, 0.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Already Have an Account? ",
                          style: GoogleFonts.secularOne(
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.0334821429,
                            color: const Color.fromARGB(255, 235, 37, 103),
                          ),
                          children: [
                            TextSpan(
                              text: "Login Account",
                              style: GoogleFonts.secularOne(
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    MediaQuery.of(context).size.width *
                                    0.0334821429,
                                color: const Color.fromARGB(255, 248, 138, 175),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        if (emailController.text.trim().isNotEmpty &&
                            passwordController.text.trim().isNotEmpty) {
                          try {
                            await _firebaseAuth.createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            if (context.mounted) {
                              snackBar(
                                text: "Account Created",
                                context: context,
                              );
                            }
                          } on FirebaseAuthException catch (error) {
                            if (context.mounted) {
                              snackBar(text: error.code, context: context);
                            }
                          } finally {
                            emailController.clear();
                            passwordController.clear();
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        } else {
                          snackBar(
                            text: "Please enter valid fields",
                            context: context,
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 248, 138, 175),
                              Color.fromRGBO(181, 0, 60, 1),
                            ],
                          ),
                        ),
                        child: Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(250, 243, 221, 1),
                            fontSize:
                                MediaQuery.of(context).size.width *
                                0.0401785714,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
