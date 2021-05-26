import 'package:booksea/ui/pages/seller/seller_controller.dart';
import 'package:get/get.dart';

class SellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerController>(() => SellerController());
  }
}