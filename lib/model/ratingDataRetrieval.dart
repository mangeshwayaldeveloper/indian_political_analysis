import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'RatingCategoryWiseModel.dart';

final categoryRatingsProvider =
    FutureProvider<Map<String, List<RatingModelRetrieve>>>((ref) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return {}; // Return an empty map if the user is not authenticated
    }

    final userUid = user.uid;

    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('ratings')
            .doc(userUid)
            .get();

    final Map<String, List<RatingModelRetrieve>> categoryRatings = {};

    final QuerySnapshot<Map<String, dynamic>> categoryQuerySnapshot =
        await userSnapshot.reference.collection('ratings').get();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> categorySnapshot
        in categoryQuerySnapshot.docs) {
      final String categoryName = categorySnapshot.id;
      final List<RatingModelRetrieve> ratings = [];

      final QuerySnapshot<Map<String, dynamic>> ratingQuerySnapshot =
          await categorySnapshot.reference.collection('ratings').get();

      for (final QueryDocumentSnapshot<Map<String, dynamic>> ratingSnapshot
          in ratingQuerySnapshot.docs) {
        final RatingModelRetrieve rating =
            RatingModelRetrieve.fromMap(ratingSnapshot.data());
        ratings.add(rating);
      }

      categoryRatings[categoryName] = ratings;
    }

    return categoryRatings;
  } catch (error, stackTrace) {
    print('Error fetching category ratings: $error');
    print(stackTrace);
    rethrow; // Rethrow the error for higher-level handling
  }
});
