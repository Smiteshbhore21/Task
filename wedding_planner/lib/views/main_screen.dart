import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wedding_planner/controllers/login_session.dart';
import 'package:wedding_planner/views/checklist_screen.dart';
import 'package:wedding_planner/views/home_screen.dart';
import 'package:wedding_planner/views/login_screen.dart';

import '../controllers/wedding_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State createState() => _MainScreenState();
}

class _MainScreenState extends State {
  final List<Widget> _pages = const [HomeScreen(), ChecklistScreen()];
  final ScrollController _scrollToHideController = ScrollController();
  int _selectedScreen = 0;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final WeddingController weddingController = Get.put(WeddingController());

  @override
  void initState() {
    super.initState();
    _scrollToHideController.addListener(() {
      if (_scrollToHideController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          weddingController.changeNavBarVisiblity(false);
        });
      } else {
        setState(() {
          weddingController.changeNavBarVisiblity(true);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Width : ${MediaQuery.of(context).size.width}");
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromRGBO(255, 241, 244, 1),
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.width * 0.146578125,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hey,",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(101, 101, 101, 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Log Out'),
                            content: ElevatedButton(
                              onPressed: () async {
                                await _firebaseAuth.signOut();
                                await LoginSession.setLoginSession(false, "");
                                if (context.mounted) {
                                  await Navigator.of(
                                    context,
                                  ).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const LoginScreen();
                                      },
                                    ),
                                    (route) => false,
                                  );
                                }
                              },
                              style: const ButtonStyle(
                                fixedSize: WidgetStatePropertyAll(Size(10, 20)),
                                backgroundColor: WidgetStatePropertyAll(
                                  Color.fromRGBO(228, 26, 94, 1),
                                ),
                              ),
                              child: Text(
                                "Log Out",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(228, 26, 94, 1),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 198, 198, 198),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollToHideController,
        child: _pages[_selectedScreen],
      ),
      bottomNavigationBar: Obx(() {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: weddingController.isVisibleNavBar.value ? 70.0 : 0.0,
          margin:
              weddingController.isVisibleNavBar.value
                  ? const EdgeInsets.all(15)
                  : const EdgeInsets.only(left: 15, right: 15),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 241, 244, 1),
            borderRadius: BorderRadius.all(Radius.circular(44)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(228, 26, 94, 0.2),
                spreadRadius: 5,
                blurRadius: 15,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedScreen = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  color:
                      _selectedScreen == 0
                          ? const Color.fromRGBO(228, 26, 94, 1)
                          : null,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedScreen = 1;
                  });
                },
                child: Icon(
                  Icons.fact_check_outlined,
                  color:
                      _selectedScreen == 1
                          ? const Color.fromRGBO(228, 26, 94, 1)
                          : null,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
