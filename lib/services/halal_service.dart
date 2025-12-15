import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/halal_data.dart';

class HalalService {
  static List<HalalData>? _cachedData;

  static Future<List<HalalData>> loadData() async {
    if (_cachedData != null) {
      return _cachedData!;
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/data.json');
      final dynamic decoded = json.decode(jsonString);

      // Support structure: { "meta": { ... }, "rules": [ ... ] }
      List<dynamic> rulesList;
      if (decoded is Map<String, dynamic> && decoded['rules'] is List) {
        rulesList = decoded['rules'] as List<dynamic>;
      } else if (decoded is List) {
        // Fallback if file is a plain list
        rulesList = decoded;
      } else {
        rulesList = <dynamic>[];
      }

      _cachedData =
          rulesList.map((item) => HalalData.fromJson(item as Map<String, dynamic>)).toList();
      return _cachedData!;
    } catch (e) {
      print('Error loading data.json: $e');
      return [];
    }
  }

  static Future<List<HalalData>> search(String query) async {
    final data = await loadData();
    final lowerQuery = query.toLowerCase();

    // Search for exact keyword matches
    final results = data.where((item) {
      return item.keywords.any((keyword) =>
          lowerQuery.contains(keyword.toLowerCase()) ||
          keyword.toLowerCase().contains(lowerQuery));
    }).toList();

    return results;
  }

  static Future<List<HalalData>> searchByKeywords(List<String> keywords) async {
    final data = await loadData();
    final results = <HalalData>[];

    for (final keyword in keywords) {
      final lowerKeyword = keyword.toLowerCase();
      final matches = data.where((item) {
        return item.keywords.any((k) =>
            k.toLowerCase() == lowerKeyword ||
            k.toLowerCase().contains(lowerKeyword) ||
            lowerKeyword.contains(k.toLowerCase()));
      }).toList();
      results.addAll(matches);
    }

    // Remove duplicates
    return results.toSet().toList();
  }
}

