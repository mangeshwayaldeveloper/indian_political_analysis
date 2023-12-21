import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingWidget extends ConsumerStatefulWidget {
  final String category;

  const RatingWidget({Key? key, required this.category}) : super(key: key);

  @override
  ConsumerState<RatingWidget> createState() => _RatingWidgetState();
}

final ratingProvider = StateProvider.family<double, String>((ref, category) => 0.0);
final  healthcareProvider= StateProvider.family<double, String>((ref, category) => 0.0);
final educationProvider = StateProvider.family<double, String>((ref, category) => 0.0);
final transportProvider = StateProvider.family<double, String>((ref, category) => 0.0);
final womensSecurityProvider = StateProvider.family<double, String>((ref, category) => 0.0);
final electricityProvider = StateProvider.family<double, String>((ref, category) => 0.0);
final pollutionProvider = StateProvider.family<double, String>((ref, category) => 0.0);
final economyProvider = StateProvider.family<double, String>((ref, category) => 0.0);
final governanceProvider = StateProvider.family<double, String>((ref, category) => 0.0);

class _RatingWidgetState extends ConsumerState<RatingWidget> {
  double userRating = 0.1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Rating: ${(userRating / 5.0 * 100).toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: userRating / 5.0,
            minHeight: 10,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
          ),
          SizedBox(height: 20),
          Slider(
            value: userRating,
            min: 0.1,
            max: 5.0,
            onChanged: (value) {
              setState(() {
                userRating = value;
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle the submission of the rating
              print('User Rating: $userRating');
              double currentRating = ref.read(ratingProvider(widget.category).notifier).state;
              double totalRating = currentRating + userRating;
              ref.read(ratingProvider(widget.category).notifier).state = totalRating;
              // Add your logic here to store the rating or perform other actions
            },
            child: Text('Submit Rating'),
          ),
          Text("User Rating $userRating"),
        ],
      ),
    );
  }
}
StateProviderFamily<double, String> getProvider(String category) {
  switch (category) {
    case "Healthcare":
      return healthcareProvider;
    case "Education":
      return educationProvider;
    case "Transport":
      return transportProvider;
  // Add more cases for other categories
    default:
      throw ArgumentError("Invalid category: $category");
  }
}