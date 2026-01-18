import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_provider.dart';
import '../controllers/login_session.dart';
import '../views/signup_screen.dart';
import '../views/task_list_screen.dart';
import '../components/social_circle.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailCtrl.text.trim().isEmpty || _passCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email & password required')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      await ref
          .read(authControllerProvider)
          .login(_emailCtrl.text, _passCtrl.text);

      if (!mounted) return;
      await LoginSession.setLoginSession(true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const TaskListScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 44),
            ),
            const SizedBox(height: 18),
            Text(
              "Welcome back!",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email address'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passCtrl,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon:
                      Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Forgot password tapped')),
                  );
                },
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: colorPrimary,
                ),
                child: _loading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Log in',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('or log in with',
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialCircle(icon: Icons.facebook),
                SizedBox(width: 12),
                SocialCircle(icon: Icons.g_mobiledata),
                SizedBox(width: 12),
                SocialCircle(icon: Icons.apple),
              ],
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignUpPage()),
                );
              },
              child: const Text(
                "Don't have an account? Get started!",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
