import 'package:get/get.dart';

class MainController extends GetxController {
  final _currentIndex = 0.obs;
  final _tabIndex = 0.obs;

  int get currentIndex => _currentIndex.value;
  int get tabIndex => _tabIndex.value;

  void changePageIndex(value) => _currentIndex.value = value;
  void changeTabIndex(value) => _tabIndex.value = value;
}