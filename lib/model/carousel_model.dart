class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image']!)).toList();

var carouselsData = [
  {"image": "Assets/Images/image/road.png"},
  {"image": "Assets/Images/image/electricity.jpg"},
  {"image": "Assets/Images/image/unemployment.jpg"},
];
