import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../model/allCategoryRatings.dart';

class CategoryData extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final economyRatings = ref.watch(economyRatingsAll);
    final educationRatings = ref.watch(educationRatingsAll);
    final electricityRatings = ref.watch(electricityRatingsAll);
    final governanceRatings = ref.watch(governanceRatingsAll);
    final healthcareRatings = ref.watch(healthcareRatingsAll);
    final pollutionRatings = ref.watch(pollutionRatingsAll);
    final transportRatings = ref.watch(transportRatingsAll);
    final womensRatings = ref.watch(womensRatingsAll);

    return Scaffold(
      appBar: AppBar(
        title: Text('Category Ratings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryListTile(categoryName: 'Economy', ratings: economyRatings),
            CategoryListTile(categoryName: 'Education', ratings: educationRatings),
            CategoryListTile(categoryName: 'Electricity', ratings: electricityRatings),
            CategoryListTile(categoryName: 'Governance', ratings: governanceRatings),
            CategoryListTile(categoryName: 'Healthcare', ratings: healthcareRatings),
            CategoryListTile(categoryName: 'Pollution', ratings: pollutionRatings),
            CategoryListTile(categoryName: 'Transport', ratings: transportRatings),
            CategoryListTile(categoryName: 'Women\'s Security', ratings: womensRatings),
          ],
        ),
      ),
    );
  }
}

class CategoryListTile extends StatelessWidget {
  final String categoryName;
  final AsyncValue<List<QueryDocumentSnapshot>> ratings;

  CategoryListTile({required this.categoryName, required this.ratings});

  @override
  Widget build(BuildContext buildContext) {
    return Consumer(
      builder: (context, ref, _) {
        return ListTile(
          title: Text(categoryName),
          subtitle: ratings.when(
            data: (docs) {
              final count=docs.length;
              if (docs.isNotEmpty) {
                final ratingsInfo = docs.map((doc) {

                  final rating = doc['rating'] ; // Adjust the field name as per your data model
                  final timestamp = doc['timestamp'] as Timestamp; // Adjust the field name as per your data model
                  final formattedTimestamp = DateFormat.yMMMd().add_jm().format(timestamp.toDate()); // Format in AM/PM


                  return 'Rating: $rating%, Time: $formattedTimestamp';
                }).join('\n');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Ratings: $count'),
                    SizedBox(height: 8), // Adjust the spacing as needed
                    Text(ratingsInfo),
                  ],
                );
              } else {
                return Text('No ratings available');
              }
            },
            loading: () => Center(child: Text('Loading...')),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
        );
      },
    );
  }
}

// Define your FutureProviders for each category (e.g., economyRatingsAll, educationRatingsAll, etc.) here.
