import 'package:booksea/ui/pages/home/booklist/listdetail/list_detail_controller.dart';
import 'package:get/get.dart';

class ListDetailBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ListDetailController>(() => ListDetailController());
  }
}