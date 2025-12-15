import 'package:flutter/material.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/gradient_button.dart';
import '../../utils/shared_preferences_helper.dart';
import '../user_guide_screen.dart';
import '../home_screen.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

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
                Icons.chat_bubble_outline,
                size: 120,
                color: Color(0xFF388E3C),
              ),
              const SizedBox(height: 40),
              GradientText(
                text: 'Ask Questions Anytime',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 30),
              const Text(
                'Use our chatbot to ask about specific ingredients or e-codes. Get instant answers with detailed explanations and sources.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF81C784).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Color(0xFF388E3C)),
                    SizedBox(width: 10),
                    Text(
                      'Search ingredients & e-codes',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GradientButton(
                text: 'Get Started',
                onPressed: () async {
                  await SharedPreferencesHelper.setOnboardingCompleted(true);
                  if (!context.mounted) return;

                  final isUserGuideShown =
                      await SharedPreferencesHelper.isUserGuideShown();

                  if (!isUserGuideShown) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserGuideScreen(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
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

