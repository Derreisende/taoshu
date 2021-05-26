import 'package:get/get.dart';
import 'package:booksea/ui/pages/home/booklist/booklist_controller.dart';

class BookListBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BookListController>(() => BookListController());
  }
}