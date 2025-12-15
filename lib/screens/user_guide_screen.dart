import 'package:flutter/material.dart';
import '../widgets/gradient_text.dart';
import '../widgets/gradient_button.dart';
import '../utils/shared_preferences_helper.dart';
import 'home_screen.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                text: 'User Guide',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              _buildGuideSection(
                icon: Icons.camera_alt,
                title: 'Taking Photos',
                description:
                    'Tap "Take Photo" to capture product labels using your camera. Make sure the text is clear and well-lit for best results.',
              ),
              const SizedBox(height: 20),
              _buildGuideSection(
                icon: Icons.photo_library,
                title: 'Uploading Images',
                description:
                    'Tap "Upload Image" to select an image from your gallery. Supported formats include JPG, PNG, and other common image types.',
              ),
              const SizedBox(height: 20),
              _buildGuideSection(
                icon: Icons.chat_bubble_outline,
                title: 'Using the Chatbot',
                description:
                    'Ask questions about ingredients or e-codes. For example: "Is E441 halal?" or "What about gelatin?". The chatbot will search our database and provide detailed answers with sources.',
              ),
              const SizedBox(height: 20),
              _buildGuideSection(
                icon: Icons.lightbulb_outline,
                title: 'Tips for Best Results',
                description:
                    '• Be specific with ingredient names\n• Include e-codes when asking (e.g., E441)\n• Check the confidence level and source for each answer\n• Multiple results may appear - review all for complete information',
              ),
              const SizedBox(height: 40),
              GradientButton(
                text: 'Got it!',
                onPressed: () async {
                  await SharedPreferencesHelper.setUserGuideShown(true);
                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
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

  Widget _buildGuideSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF81C784).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF81C784).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF388E3C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF388E3C),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

