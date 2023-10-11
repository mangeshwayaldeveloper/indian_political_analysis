class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image']!)).toList();

var carouselsData = [
  {"image": "Assets/Images/image/loginpageimage.jpg"},
  {"image": "Assets/Images/image/road.jpg"},
  {"image": "Assets/Images/image/road.jpg"},
];
