import 'package:booksea/ui/pages/qrscan/QRController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:booksea/ui/utils/utils.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/core/extension/num_extension.dart';

class QRScanView extends GetView<QRController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("扫一扫",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        //返回按钮
        leading: IconButton(
          iconSize: 16.px,
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Get.back();
          },
        ),
        actions: [
          //相册按钮
          TextButton(
            child: Text("相册",style: TextStyle(fontSize: 16.px),),
            onPressed: (){
              controller.handlePickPhoto();
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                //默认状态使用灰色
                return Colors.white;
              },
              ),
            ),
          )
        ],
        toolbarOpacity: 1,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
           _buildQrView(context),
            Positioned(
                top: Get.height / 2 + Get.width / 1.6 / 2 + 20.px,
                child:IconButton(
                  icon: Obx(()=>Icon(controller.flashOpen.isTrue? MyIcons.flashlight_opened
                  : MyIcons.flashlight_closed)),
                  iconSize: 50.px,
                  color: Colors.white,
                  onPressed: () async{
                    myDebounce((){
                      controller.toggoleFlash();
                    })();
                  },
                )
            ),
            Positioned(
                top: Get.height / 2 - Get.width / 1.6 / 2 - 30.px,
                child: Text("对准条形码/二维码到框内即可扫描",style: TextStyle(color:Colors.white),)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    QRController QRCtl = Get.find<QRController>();
    var scanArea = Get.width / 1.6;
    // 构建扫描框
    return QRView(
      key: qrKey,
      //扫描框创建后执行onQRViewCreated()方法
      onQRViewCreated: QRCtl.onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.lightBlueAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 3.px,
          cutOutSize: scanArea),
    );
  }
}