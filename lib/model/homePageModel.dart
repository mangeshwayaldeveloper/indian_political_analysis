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
    upcomingEventModel("MLA", "MLA For 2023",
        "Special Guest Will Be There", "Assets/images/event.png", null),
    upcomingEventModel("Corporator", "National Teachers Day",
        "On the 5th Sep", "Assets/images/fe.png", null),
    upcomingEventModel("State Government", "Celebrating ganesh Festival 2024",
        "In college premises", "Assets/images/festival.png", null),
  ];
}
