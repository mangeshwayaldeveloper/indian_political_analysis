// category_rating_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModelRetrieve {
  final double rating;
  final Timestamp timestamp;

  RatingModelRetrieve({
    required this.rating,
    required this.timestamp,
  });

  factory RatingModelRetrieve.fromMap(Map<String, dynamic> map) {
    return RatingModelRetrieve(
      rating: map['rating'] ?? 0.0,
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
