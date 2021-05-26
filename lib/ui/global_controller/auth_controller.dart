import 'package:booksea/ui/pages/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

import 'package:booksea/core/services/request/auth_service.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/pages/cart/cart_model.dart';
import 'package:booksea/core/model/user_model.dart';
import 'package:booksea/core/router/app_pages.dart';

class AuthController extends GetxController {
  final isLogged = false.obs;
  final _user = UserModel().obs;
  final showBadge = true.obs;
  final _logoutState = false.obs;

  bool get isLog => isLogged.value;
  UserModel get user => _user.value;
  bool get logoutState => _logoutState.value;
  void  changeLogoutState(value){
    _logoutState.value = value;
  }

  //初始化用户信息
  void initUser(user) {
    _user.value = user;
    _user.refresh();
  }

  void setUser() async {
    ApiResponse userInfo = await AuthService.getUser(refresh: true);
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    if(userModel != null){
      initUser(userModel);
    }
  }
  void handleLog() {
    isLogged.value = hasToken();
  }

  ifAuth(){
    if(isLogged.value == false) {
      Get.toNamed(AppPages.LOGIN);
    }
  }

  bool hasToken() {
    if(SpUtil.getString("accessToken") == null || SpUtil.getString("accessToken") =="") {
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    UserModel userModel = SpUtil.getObj("userInfo", (v) => UserModel.fromJson(v));
    if(userModel != null){
      initUser(userModel);
      isLogged.value = true;
    }
    if(isLog == true){
      showBadge.value = !showBadge.value;
    }
    super.onInit();
  }

  @override
  void onReady() {
    ever(isLogged,(_){
      showBadge.value = !showBadge.value;
    });
    ever(_user,(_){
      if(isLog){
        CartController cartCtl = Get.find<CartController>();
         List<CartModel> carts = SpUtil.getObjList(user.phoneNumber+"cart",(v)=>CartModel.fromJson(v));
        if(carts != null){
          cartCtl.cartList.assignAll(carts);
        }
      }
    });
    if(isLog){
      CartController cartCtl = Get.find<CartController>();
      List<CartModel> carts = SpUtil.getObjList(user.phoneNumber+"cart",(v)=>CartModel.fromJson(v));
      if(carts != null){
        cartCtl.cartList.assignAll(carts);
      }
    }
    super.onReady();
  }
}
