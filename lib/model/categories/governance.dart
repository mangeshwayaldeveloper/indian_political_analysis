import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final governanceRatings= FutureProvider.autoDispose<DocumentSnapshot>(
      (ref) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is not authenticated
      return Future.error('User not authenticated');
    }

    // Query the 'education' collection to get the latest document
    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid) // Assuming user.uid is the user's ID
        .collection('governance')
        .orderBy('timestamp', descending: true) // Assuming 'timestamp' is the field indicating the time
        .limit(1)
        .get();

    // Check if any documents were found
    if (querySnapshot.docs.isNotEmpty) {
      // Retrieve the latest document ID
      var latestDocumentID = querySnapshot.docs.first.id;

      // Use the latest document ID to get the corresponding document
      var documentReference = FirebaseFirestore.instance
          .collection('ratings')
          .doc(user.uid)
          .collection('governance')
          .doc(latestDocumentID);

      var snapshot = await documentReference.get();
      return snapshot;
    } else {
      // Handle the case where no documents were found
      return Future.error('No rating documents found');
    }
  },
);
