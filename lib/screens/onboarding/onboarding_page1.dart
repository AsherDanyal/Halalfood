import 'package:flutter/material.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/gradient_button.dart';
import 'onboarding_page2.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu,
                size: 120,
                color: Color(0xFF388E3C),
              ),
              const SizedBox(height: 40),
              GradientText(
                text: 'Welcome to Halal Food Identifier',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 30),
              const Text(
                'Discover halal food products with ease. Our app helps you identify halal and haram ingredients quickly and accurately.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              GradientButton(
                text: 'Next',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage2(),
                    ),
                  );
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

