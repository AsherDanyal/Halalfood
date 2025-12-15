import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _userGuideShownKey = 'user_guide_shown';

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  static Future<void> setOnboardingCompleted(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, value);
  }

  static Future<bool> isUserGuideShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userGuideShownKey) ?? false;
  }

  static Future<void> setUserGuideShown(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userGuideShownKey, value);
  }
}

