import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final economyRatingsAll = FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is not authenticated
      return Future.error('User not authenticated');
    }

    // Query the 'economy' collection to get all documents
    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid) // Assuming user.uid is the user's ID
        .collection('economy')
        .orderBy('timestamp', descending: true) // Assuming 'timestamp' is the field indicating the time
        .get();

    // Return the list of all documents
    return querySnapshot.docs;
  },
);
final educationRatingsAll = FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Future.error('User not authenticated');
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid)
        .collection('education')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  },
);
final electricityRatingsAll= FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Future.error('User not authenticated');
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid)
        .collection('electricity')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  },
);
final governanceRatingsAll = FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Future.error('User not authenticated');
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid)
        .collection('governance')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  },
);
final healthcareRatingsAll= FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Future.error('User not authenticated');
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid)
        .collection('healthcare')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  },
);
final pollutionRatingsAll= FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Future.error('User not authenticated');
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid)
        .collection('pollution')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  },
);
final transportRatingsAll= FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Future.error('User not authenticated');
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid)
        .collection('transport')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  },
);

final womensRatingsAll= FutureProvider.autoDispose<List<QueryDocumentSnapshot>>(
      (ref) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Future.error('User not authenticated');
    }

    var querySnapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .doc(user.uid)
        .collection('womensSecurity')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  },
);
