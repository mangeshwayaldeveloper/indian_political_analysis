class RatingData {
  double totalRating = 0.0;
  int totalDays = 0;

  double get averageRating => totalDays > 0 ? totalRating / totalDays : 0.0;

  void addRating(double rating) {
    totalRating += rating;
    totalDays++;
  }
}
