import 'package:gc_gallery/models/album.dart';
import 'package:get/get.dart';
// import 'photo_model.dart';

class GalleryController extends GetxController {
  var albums = <Album>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAlbums(); // Load albums on initialization
  }

  void fetchAlbums() {
    // You can replace this with data from an API or database
    albums.value = [
      Album("Graduation Ceremony", [
        Photo("assets/graduation1.jpg", "Ceremony Photo 1"),
        Photo("assets/graduation2.jpg", "Ceremony Photo 2"),
        // Add more photos
      ]),
      Album("Departmental Photos", [
        Photo("assets/department1.jpg", "Department Photo 1"),
        Photo("assets/department2.jpg", "Department Photo 2"),
        // Add more photos
      ]),
      Album("Class Photos", [
        Photo("assets/class1.jpg", "Class Photo 1"),
        Photo("assets/class2.jpg", "Class Photo 2"),
        // Add more photos
      ]),
      Album("Farewell Party", [
        Photo("assets/farewell1.jpg", "Farewell Photo 1"),
        Photo("assets/farewell2.jpg", "Farewell Photo 2"),
        // Add more photos
      ]),
    ];
  }
}
