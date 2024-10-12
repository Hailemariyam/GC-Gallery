import 'package:gc_gallery/models/carousel_item.dart';
import 'package:get/get.dart';

class CarouselController extends GetxController {
  var classPhotos = [
    CarouselItem(
      title: 'Class Photo 1',
      description: 'Description of Class Photo 1',
      image: 'assets/images/logo.jpeg', // Change to your actual image path
    ),
    CarouselItem(
      title: 'Class Photo 2',
      description: 'Description of Class Photo 2',
      image: 'assets/images/logo.jpeg', // Change to your actual image path
    ),
    // Add more CarouselItems as needed
  ].obs;
}
