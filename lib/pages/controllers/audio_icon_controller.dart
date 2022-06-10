import 'package:get/get.dart';

class IconController extends GetxController {
  RxBool isPlaying = false.obs;
  RxBool isFavourite = false.obs;
}

class SearchController extends GetxController {
  RxList allData = [].obs;
  RxList recentData = [].obs;
}
