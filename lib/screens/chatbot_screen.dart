import 'package:flutter/material.dart';
import '../widgets/gradient_text.dart';
import '../widgets/gradient_button.dart';
import '../services/halal_service.dart';
import '../models/halal_data.dart';
import 'user_guide_screen.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(ChatMessage(
      text: 'Hello! I can help you identify halal and haram ingredients. Ask me about any ingredient or e-code.',
      isUser: false,
    ));
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _controller.clear();
      _isLoading = true;
    });

    _scrollToBottom();

    // Search for matching data
    final results = await HalalService.search(text);

    setState(() {
      _isLoading = false;
      if (results.isEmpty) {
        _messages.add(ChatMessage(
          text: 'I couldn\'t find information about "$text" in the database. Please try asking about a specific ingredient or e-code.',
          isUser: false,
        ));
      } else {
        for (final result in results) {
          _messages.add(ChatMessage(
            text: _formatResult(result),
            isUser: false,
            halalData: result,
          ));
        }
      }
    });

    _scrollToBottom();
  }

  String _formatResult(HalalData data) {
    final normalizedStatus = data.status.toLowerCase();
    final statusWord = normalizedStatus.isEmpty ? 'unknown' : normalizedStatus;

    return 'This is $statusWord due to ${data.reason}. (Source: ${data.source})';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon( .arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: GradientText(
          text: 'Chatbot',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserGuideScreen(),
                ),
              );
            },
            tooltip: 'User Guide',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF388E3C),
                      ),
                    ),
                  );
                }
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about ingredients or e-codes...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Color(0xFF388E3C),
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF81C784), // Light green (top)
                          Color(0xFF388E3C), // Dark green (bottom)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? const Color(0xFF388E3C)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser && message.halalData != null) ...[
              _buildStatusIndicator(message.halalData!),
              const SizedBox(height: 8),
              _buildConfidenceIndicator(message.halalData!),
            ],
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(HalalData data) {
    final isHalal = data.status.toLowerCase() == 'halal';
    final isHaram = data.status.toLowerCase() == 'haram';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isHalal
            ? Colors.green.shade50
            : isHaram
                ? Colors.red.shade50
                : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHalal
              ? Colors.green
              : isHaram
                  ? Colors.red
                  : Colors.orange,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            data.status.toUpperCase(),
            style: TextStyle(
              color: isHalal
                  ? Colors.green.shade900
                  : isHaram
                      ? Colors.red.shade900
                      : Colors.orange.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceIndicator(HalalData data) {
    final confidence = data.confidence.toLowerCase();
    
    // Determine confidence color
    Color confidenceColor;
    if (confidence == 'high') {
      confidenceColor = Colors.green;
    } else if (confidence == 'medium') {
      confidenceColor = Colors.orange;
    } else {
      confidenceColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: confidenceColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: confidenceColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.assessment,
            color: confidenceColor,
            size: 16,
          ),
          const SizedBox(width: 6),
          const Text(
            'CONFIDENCE: ',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Text(
            confidence.toUpperCase(),
            style: TextStyle(
              color: confidenceColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final HalalData? halalData;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.halalData,
  });
}

