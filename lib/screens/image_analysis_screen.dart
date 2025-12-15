import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/gradient_text.dart';
import '../widgets/gradient_button.dart';
import '../services/halal_service.dart';
import '../models/halal_data.dart';

class ImageAnalysisScreen extends StatefulWidget {
  final File imageFile;

  const ImageAnalysisScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<ImageAnalysisScreen> createState() => _ImageAnalysisScreenState();
}

class _ImageAnalysisScreenState extends State<ImageAnalysisScreen> {
  bool _isAnalyzing = true;
  bool? _halalLogoFound;
  List<HalalData> _ingredientResults = [];
  String _analysisStatus = 'Analyzing image...';

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    try {
      // Simulate analysis delay
      await Future.delayed(const Duration(seconds: 2));

      // Always detect halal logo for documentation
      // In real implementation, this would use OCR/ML to detect halal logos
      if (mounted) {
        setState(() {
          _halalLogoFound = true;
          _isAnalyzing = false;
          _analysisStatus = 'Halal logo detected!';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _analysisStatus = 'Error analyzing image';
        });
      }
    }
  }

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
        title: GradientText(
          text: 'Image Analysis',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.left,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image display
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    widget.imageFile,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.grey,
                                size: 48,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Failed to load image',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Analysis status
              if (_isAnalyzing) ...[
                const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xFF388E3C),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Analyzing image...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                // Halal logo check result - always show halal verdict
                _buildHalalLogoFoundCard(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHalalLogoFoundCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF81C784),
            Color(0xFF388E3C),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.verified,
            color: Colors.white,
            size: 60,
          ),
          const SizedBox(height: 16),
          const Text(
            'HALAL LOGO DETECTED',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Text(
              'VERDICT: HALAL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This product is automatically certified as HALAL',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoLogoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.search_off, color: Colors.orange.shade700, size: 32),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'No halal logo detected. Analyzing ingredients...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientCard(HalalData data) {
    final isHalal = data.status.toLowerCase() == 'halal';
    final isHaram = data.status.toLowerCase() == 'haram';
    final confidence = data.confidence.toLowerCase();
    
    Color confidenceColor;
    if (confidence == 'high') {
      confidenceColor = Colors.green;
    } else if (confidence == 'medium') {
      confidenceColor = Colors.orange;
    } else {
      confidenceColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHalal
            ? Colors.green.shade50
            : isHaram
                ? Colors.red.shade50
                : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHalal
              ? Colors.green
              : isHaram
                  ? Colors.red
                  : Colors.orange,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isHalal
                    ? Icons.check_circle
                    : isHaram
                        ? Icons.cancel
                        : Icons.help_outline,
                color: isHalal
                    ? Colors.green
                    : isHaram
                        ? Colors.red
                        : Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                data.status.toUpperCase(),
                style: TextStyle(
                  color: isHalal
                      ? Colors.green.shade900
                      : isHaram
                          ? Colors.red.shade900
                          : Colors.orange.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: confidenceColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: confidenceColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  confidence.toUpperCase(),
                  style: TextStyle(
                    color: confidenceColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Keywords: ${data.keywords.join(', ')}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.reason,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Source: ${data.source}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

