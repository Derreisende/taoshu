import 'package:booksea/ui/pages/category/cateSearch/catesearch_controller.dart';
import 'package:get/get.dart';

class CateSearchBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CateSearchController>(() => CateSearchController());
  }
}