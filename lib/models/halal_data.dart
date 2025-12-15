class HalalData {
  final String? id;
  final List<String> keywords;
  final String status;
  final String confidence;
  final String reason;
  final String category;
  final String source;

  HalalData({
    this.id,
    required this.keywords,
    required this.status,
    required this.confidence,
    required this.reason,
    required this.category,
    required this.source,
  });

  factory HalalData.fromJson(Map<String, dynamic> json) {
    return HalalData(
      id: json['id'] as String?,
      keywords: List<String>.from(json['keywords'] ?? []),
      status: json['status'] ?? '',
      confidence: json['confidence'] ?? '',
      reason: json['reason'] ?? '',
      category: json['category'] ?? '',
      source: json['source'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'keywords': keywords,
      'status': status,
      'confidence': confidence,
      'reason': reason,
      'category': category,
      'source': source,
    };
  }
}

