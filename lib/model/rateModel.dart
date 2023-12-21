import 'dart:ui';

class upcomingEventModel {
  final String title;
  final String heading;
  final String subHeading;
  final String image;
  final VoidCallback? onPress;

  upcomingEventModel(
      this.title, this.heading, this.subHeading, this.image, this.onPress);

  static List<upcomingEventModel> list = [
    upcomingEventModel("MCA Induction Program", "Induction For MCA Batch-2024",
        "Special Guest Will Be There", "Assets/images/event.png", null),
    upcomingEventModel("Celebrating Teachers Day", "National Teachers Day",
        "On the 5th Sep", "Assets/images/fe.png", null),
    upcomingEventModel("Ganesh Festival-2023", "Celebrating ganesh Festival 2024",
        "In college premises", "Assets/images/festival.png", null),
  ];
}
