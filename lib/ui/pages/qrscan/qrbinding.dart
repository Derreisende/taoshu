import 'package:booksea/ui/pages/qrscan/QRController.dart';
import 'package:get/get.dart';

class QRBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QRController>(() => QRController());
  }
}