import 'package:flutter/material.dart';
import 'package:task_manager/services/auth_router.dart';
import 'package:task_manager/views/task_list_screen.dart';
import '../controllers/login_session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startUpSequence();
  }

  Future<void> _startUpSequence() async {
    await Future.delayed(const Duration(seconds: 1));

    final isLoggedIn = await LoginSession.getLoginSession();
    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const TaskListScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const AuthPager(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlutterLogo(size: 100),
      ),
    );
  }
}
