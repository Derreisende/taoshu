import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'cart_model.dart';
import 'package:booksea/core/model/Commodity_model.dart';

class CartController extends GetxController{
  AuthController authCtl = Get.find<AuthController>();

  final _allCheck = false.obs;
  final _totalPrice = 0.00.obs;
  //选中数量
  final _checkNum = 0.obs;

  //商品列表
  final cartList = <CartModel>[].obs;

  bool get allCheck => _allCheck.value;
  double get totalPrice => _totalPrice.value;
  int get checkNum => _checkNum.value;

  void changIdxCheck(index){
    cartList[index].isCheck = !cartList[index].isCheck;
  }

  //计算总价
  void sum(){
    num total = 0;
    int check = 0;
   cartList.forEach((element) {
     if(element.isCheck){
       total += num.parse(element.count.toString()) * num.parse(element.customPrice);
       check ++;
     }
   });
   _totalPrice.value = total.toDouble();
   _checkNum.value = check;
  }

  void addCart(List<CartModel> cartlist, CartModel cart) {
    List<CartModel> l1 = [];
    l1.addAll(cartlist);

    //查看是否添加过
    bool oldCom = cartlist.any((element) => element.artNo == cart.artNo);
    if (oldCom) {
      l1.forEach((element) {
        if(element.artNo == cart.artNo){
          element.count++;
        }
      });
      cartList.assignAll(l1);
    }else{
      cartList.add(cart);
    }
    sum();
    Fluttertoast.showToast(
        msg:"添加购物车成功",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 14.0.px
    );
  }

  //商品数量-1
  void minusCommodity(index){
    if(cartList[index].count >1 ){
      cartList[index].count--;
    }
  }
  //商品数量+1
  void addCommodity(index){
    cartList[index].count++;
  }

  //删除商品
  void deCommodity(index){
    cartList.removeAt(index);
  }

  //全选
  void changAllCheck(value){
    _allCheck.value = value;
    cartList.forEach((element) {
      element.isCheck = value;
    });
    sum();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    ever(cartList, (_) {
      if(authCtl.isLog){
        SpUtil.putObjectList(authCtl.user.phoneNumber+"cart", cartList);
      }
    });
    ever(cartList, (_){
      if(cartList.length !=0){
        sum();
      }
    });
    super.onReady();
  }
}