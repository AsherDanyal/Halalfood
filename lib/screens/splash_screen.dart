import 'package:flutter/material.dart';
import '../utils/shared_preferences_helper.dart';
import '../widgets/gradient_text.dart';
import 'onboarding/onboarding_page1.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Always show onboarding for documentation screenshots
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingPage1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.restaurant_menu,
              size: 100,
              color: Color(0xFF388E3C),
            ),
            const SizedBox(height: 20),
            GradientText(
              text: 'Halal Food Identifier',
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const Text(
              'Your trusted guide to halal food',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

