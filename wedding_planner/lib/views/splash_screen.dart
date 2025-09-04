import 'package:flutter/material.dart';
import 'package:wedding_planner/controllers/login_session.dart';
import 'package:wedding_planner/views/login_screen.dart';
import 'package:wedding_planner/views/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreen();
}

class _SplashScreen extends State {
  @override
  void initState() {
    super.initState();
    _startUpSequence();
  }

  Future<void> _startUpSequence() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      if (LoginSession.isLoggin) {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 26, 94, 1),
      body: Center(
        child: Image.asset(
          "assets/splash_screen/wedding_icon.png",
          color: Colors.white,
        ),
      ),
    );
  }
}
