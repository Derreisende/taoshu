import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/profile/mypublish/mypublish_controller.dart';
import 'package:booksea/core/model/book_model.dart';
import 'package:booksea/core/services/request/home_service.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/core/services/api_response.dart';
import 'package:booksea/core/services/request/user_service.dart';
import 'package:sp_util/sp_util.dart';

class PublishController extends GetxController {
  final args = Get.arguments;
  TextEditingController freightCtl;
  TextEditingController priceCtl;

  final _bookInfo = BookModel().obs;
  final _isbn = "".obs;
  final _customPrice = "".obs;
  final _freight = "".obs;
  final _appearance = "".obs;
  final _deliveryLocation = "".obs;
  final _firstCategory = "".obs;
  final _secondCategory = "".obs;
  final _artNo = "".obs;

  String get isbn => _isbn.value;
  String get artNo => _artNo.value;

  String get customPrice => _customPrice.value;

  void  setCustomPrice(value) {
    _customPrice.value = value;
  }

  get freight => _freight.value;
  void setFreight(value) {
    _freight.value = value;
  }
  get appearance => _appearance.value;
  void setAppearance(value) => _appearance.value = value;

  get deliveryLocation => _deliveryLocation.value;
  void  setDeliveryLocation(value) {
    _deliveryLocation.value = value;
  }

  get firstCategory => _firstCategory.value;
  void setFirstCategory(value) {
    _firstCategory.value = value;
  }

  get secondCategory => _secondCategory.value;
  void setSecondCategory(value) {
    _secondCategory.value = value;
  }

  get bookInfo => _bookInfo.value;

  void setPubInfo(args){
    freightCtl.text = args.freight;
    priceCtl.text = args.customPrice;
    setCustomPrice(args.customPrice);
    setFreight(args.freight);
    setAppearance(args.appearance);
    setFirstCategory(args.firstCategory);
    setSecondCategory(args.secondCategory[0]);
    setDeliveryLocation(args.deliveryLocation);
    this._isbn.value = args.isbn;
    loadBookInfo(args.isbn);
  }

  //??????????????????
  void handlePublish({
      String artNo,
      String isbn,
      String customPrice,       //????????????
      String freight,           //??????
      String appearance,        //??????
      String deliveryLocation,  //?????????
      String firstCategory,     //????????????
      String secondCategory     //????????????
      }) async{
    try{
      //?????????????????????????????????
        ApiResponse res = await UserService.publishBook(
            artNo: artNo, isbn:isbn, customPrice:customPrice,
            freight:freight, appearance:appearance, deliveryLocation:deliveryLocation,
            firstCategory:firstCategory, secondCategory: secondCategory);
       String msg = res.data;  //?????????????????????????????????
      //??????????????????
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0.px
      );
    }catch(e) {
      Fluttertoast.showToast(
          msg: "????????????",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0.px
      );
    }
  }
  //??????????????????
  void loadBookInfo(String isbn,{bool refresh}) async{
    try{
      ApiResponse book = await HomeService.getBookInfo(isbn);
      _bookInfo.value = book.data;
      print(bookInfo.isbn);
      if(book.status == Status.ERROR){
        Fluttertoast.showToast(
            msg: book.exception.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 14.0.px
        );
      }
    }catch(e) {
      Fluttertoast.showToast(
          msg: "????????????",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 14.0.px
      );
    }
  }

  @override
  void onInit() {
    priceCtl = new TextEditingController();
    freightCtl = new TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    if(args.runtimeType == String){
      this._isbn.value = args;
      loadBookInfo(isbn);
    }else{
      _artNo.value = args.artNo;
      setPubInfo(args);
    }
    super.onReady();
  }

  @override
  void onClose() {
    priceCtl.dispose();
    freightCtl.dispose();
    super.onClose();
  }
}