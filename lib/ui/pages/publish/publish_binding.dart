import 'package:booksea/ui/pages/publish/publish_controller.dart';
import 'package:get/get.dart';

class PublishBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PublishController>(() => PublishController());
  }
}