import 'package:get/get.dart';

import 'package:booksea/ui/pages/home/home_controller.dart';

class BookListController extends GetxController{
  HomeController homeCtl = Get.find<HomeController>();

  final booklists = [].obs;

  @override
  void onInit() {
    booklists.assignAll(homeCtl.bookList);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}