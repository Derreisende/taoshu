import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:booksea/core/router/app_pages.dart';

class QRController extends GetxController {
  final arg = Get.arguments;

  final _result = Rx<Barcode>();
  QRViewController QRViewCtl;
  final flashOpen = false.obs;

  Barcode get result => _result.value;
  bool get getflashOpen => flashOpen.value;

  void setResult(value) => _result.value = value;
  void setFlashOpen(value) => flashOpen.value = value;

  //进入扫描页后
  void onQRViewCreated(QRViewController controller) {
      QRViewCtl = controller;
      //监听扫描
      QRViewCtl.scannedDataStream.listen((scanData) {
        //设置扫描到的数据
        setResult(scanData);
        if(result.code != null){
          if(arg == "searchBook"){
            //跳转到图书详情页
            Get.toNamed(AppPages.BOOK, arguments: result.code);
          }else if(arg == "publish"){
            //跳转到商品上传页
            Get.toNamed(AppPages.PUBLISH, arguments: result.code);
          }

        }
    });
  }

  //切换闪光灯
  void toggoleFlash() async {
    await QRViewCtl?.toggleFlash();
    bool isOpen = await QRViewCtl?.getFlashStatus();
    setFlashOpen(isOpen);
  }

  void handlePickPhoto(){

  }

  @override
  void onInit() {

    super.onInit();
  }



  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    QRViewCtl.dispose();
    super.onClose();
  }
}