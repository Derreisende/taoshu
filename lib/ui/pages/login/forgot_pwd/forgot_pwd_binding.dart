import 'package:get/get.dart';
import 'package:booksea/ui/pages/login/forgot_pwd/forgot_pwd_controller.dart';

class ForgotPwdBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPwdController>(() => ForgotPwdController());
  }
}
