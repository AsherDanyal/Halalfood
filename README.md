# Halal Food Identifier App

A Flutter mobile application that helps users identify halal food products through image capture/upload and an intelligent chatbot that searches ingredients and e-codes in a comprehensive halal/haram database.

## 📱 Features

### Core Functionality
- **Image Analysis**: Capture or upload product images to detect halal logos and analyze ingredients
- **Chatbot Interface**: Ask questions about specific ingredients or e-codes and get instant halal/haram status
- **Comprehensive Database**: Search through an extensive database of ingredients with status, confidence, reason, and source information
- **User-Friendly UI**: Modern Material Design 3 interface with gradient styling

### App Flow
1. **Splash Screen**: Welcome screen with app branding
2. **Onboarding**: 3-page introduction explaining app features
3. **User Guide**: Comprehensive help documentation (shown once, accessible anytime)
4. **Home Screen**: Main interface with image capture/upload options
5. **Image Analysis**: Automatic halal logo detection and ingredient analysis
6. **Chatbot**: Interactive Q&A for ingredient queries

## 🎨 Design

- **Color Scheme**: Light green to dark green gradients (#81C784 to #388E3C)
- **Background**: Clean white background throughout
- **Components**: Custom gradient buttons and text widgets
- **Status Indicators**: Color-coded halal (green) and haram (red) status badges
- **Confidence Levels**: Visual indicators for high (green), medium (orange), and low (red) confidence

## 🛠️ Technologies Used

### Backend
- **Flutter SDK**: Cross-platform framework
- **Dart SDK**: Programming language (v3.9.2+)
- **Material Design 3**: Modern UI design system
- **JSON Parsing**: Manual parsing for ingredient database
- **File I/O Operations**: Image file handling

### Frontend
- **Flutter Widgets**: UI building blocks
- **StatefulWidget**: State management
- **Navigator Routing**: Screen navigation
- **Custom Gradient Widgets**: Reusable styled components
- **Material Design 3 Components**: Pre-built UI elements

### Dependencies
- `image_picker: ^1.0.7` - Camera and gallery access
- `shared_preferences: ^2.2.2` - Local data persistence
- `cupertino_icons: ^1.0.8` - iOS-style icons

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point and routing
├── models/
│   └── halal_data.dart         # Data model for halal/haram entries
├── screens/
│   ├── splash_screen.dart      # Initial splash screen
│   ├── onboarding/
│   │   ├── onboarding_page1.dart
│   │   ├── onboarding_page2.dart
│   │   └── onboarding_page3.dart
│   ├── user_guide_screen.dart  # User guide/help screen
│   ├── home_screen.dart        # Main screen with image capture
│   ├── image_analysis_screen.dart # Image analysis results
│   └── chatbot_screen.dart     # Chatbot for ingredient queries
├── services/
│   └── halal_service.dart      # Data loading and search service
├── utils/
│   └── shared_preferences_helper.dart # Preference management
└── widgets/
    ├── gradient_button.dart    # Reusable gradient button widget
    └── gradient_text.dart      # Reusable gradient text widget
assets/
└── data.json                   # Halal/haram ingredient database
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (3.9.2 or higher)
- Android Studio / VS Code with Flutter extensions
- Android device/emulator or iOS device/simulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd cv4
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Android Permissions
The app requires the following permissions (already configured in `AndroidManifest.xml`):
- Camera access
- Read external storage (for gallery)
- Write external storage (for Android SDK 32 and below)

## 📖 Usage

### Taking/Uploading Images
1. Tap **"Take Photo"** to capture an image using the camera
2. Tap **"Upload Image"** to select an image from your gallery
3. The app will automatically analyze the image for halal logos
4. View the analysis results with halal/haram verdict

### Using the Chatbot
1. Tap the floating action button (bot icon) on the home screen
2. Type your question about an ingredient or e-code (e.g., "Is E441 halal?" or "What about gelatin?")
3. The chatbot will search the database and display:
   - Status (Halal/Haram) with color-coded indicator
   - Confidence level (High/Medium/Low) in a separate box
   - Reason for the status
   - Source of the information

### Accessing User Guide
- Tap the help icon (?) in the app bar on home screen or chatbot screen
- The guide provides instructions on using all app features

## 📊 Data Format

The app uses `assets/data.json` with the following structure:

```json
{
  "meta": {
    "version": "1.0",
    "total_rules": 812,
    "disclaimer": "..."
  },
  "rules": [
    {
      "id": "P001",
      "keywords": ["pork", "pig", "bacon"],
      "status": "haram",
      "confidence": "high",
      "reason": "Pork and all pig-derived products are explicitly forbidden in Islam.",
      "category": "pork",
      "source": "Qur'an 2:173"
    }
  ]
}
```

## 🔍 Search Functionality

The chatbot uses exact keyword matching:
- Searches through all keywords in the database
- Matches partial and full keyword strings
- Returns all matching entries with full details
- Displays multiple results if multiple ingredients match

## 🎯 Key Features Explained

### Image Analysis
- **Halal Logo Detection**: Automatically detects halal certification logos (currently shows dummy result for documentation)
- **Ingredient Analysis**: Analyzes product ingredients against the database
- **Visual Feedback**: Color-coded status indicators with confidence levels

### Chatbot
- **Real-time Search**: Instant search through the ingredient database
- **Multiple Results**: Shows all matching entries for comprehensive information
- **Source Attribution**: Displays the source of each halal/haram determination
- **Confidence Indicators**: Visual confidence levels for each result

## 🔮 Future Enhancements

- [ ] OCR integration for automatic text extraction from product labels
- [ ] ML model integration for halal logo detection
- [ ] Fuzzy matching for ingredient search
- [ ] Barcode scanning for product lookup
- [ ] Offline mode with local database caching
- [ ] User favorites and history
- [ ] Multi-language support

## 📝 Notes

- The image analysis currently shows a fixed "Halal Logo Detected" result for documentation purposes
- Onboarding is set to show every time for documentation screenshots
- The chatbot uses exact keyword matching - future versions may include fuzzy matching
- All data is stored locally in the app assets

## 🤝 Contributing

This is a project for halal food identification. Contributions and improvements are welcome!

## 📄 License

This project is private and not published to pub.dev.

## 👨‍💻 Development

Developed using:
- **IDE**: Cursor IDE with AI-assisted development
- **Version Control**: Git
- **Build Tool**: Flutter CLI
- **Linting**: Flutter Lints

---

**Version**: 1.0.0+1  
**SDK**: Flutter 3.9.2+  
**Platform**: Android, iOS, Web, Windows, macOS, Linux
