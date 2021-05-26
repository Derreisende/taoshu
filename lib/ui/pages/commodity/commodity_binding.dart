import 'package:booksea/ui/pages/commodity/commodity_controller.dart';
import 'package:get/get.dart';

class CommodityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommodityController>(() => CommodityController());
  }
}