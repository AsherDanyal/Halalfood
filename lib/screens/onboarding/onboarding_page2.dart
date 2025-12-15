import 'package:flutter/material.dart';
import '../../widgets/gradient_text.dart';
import '../../widgets/gradient_button.dart';
import 'onboarding_page3.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

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
                Icons.camera_alt,
                size: 120,
                color: Color(0xFF388E3C),
              ),
              const SizedBox(height: 40),
              GradientText(
                text: 'Capture & Upload Images',
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 30),
              const Text(
                'Take a photo of product labels or upload images from your gallery. Our app will help you identify ingredients and e-codes.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFeature(Icons.photo_camera, 'Take Photo'),
                  const SizedBox(width: 30),
                  _buildFeature(Icons.photo_library, 'Upload Image'),
                ],
              ),
              const Spacer(),
              GradientButton(
                text: 'Next',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage3(),
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

  Widget _buildFeature(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF81C784).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 40, color: const Color(0xFF388E3C)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

