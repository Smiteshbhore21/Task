import 'package:flutter/material.dart';
import 'package:task_manager/views/login_screen.dart';
import '../views/onboarding_screen.dart';

class AuthPager extends StatefulWidget {
  const AuthPager({super.key});

  @override
  State<AuthPager> createState() => _AuthPagerState();
}

class _AuthPagerState extends State<AuthPager> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -180,
            bottom: -180,
            child: Container(
              width: 420,
              height: 420,
              padding: const EdgeInsets.only(
                right: 40,
                bottom: 100,
              ),
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(210),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
          ),
          const OnboardingPage(),
        ],
      ),
    );
  }
}
