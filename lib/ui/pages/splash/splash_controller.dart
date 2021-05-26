import 'package:get/get.dart';
import 'package:booksea/core/router/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(AppPages.INITIAL_ROUTE);
    super.onReady();
  }

  @override
  void onClose() {

    super.onClose();
  }
}
