import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs; // Observable integer

  void changeIndex(int index) {
    selectedIndex.value = index; // Update the selected index
  }
}
