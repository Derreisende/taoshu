import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/seller/seller_content.dart';
import 'package:booksea/ui/pages/seller/seller_controller.dart';

class SellerView extends GetView<SellerController> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Obx(()=> controller.sellerInfo.nickname == null ? Text(""):Text(controller.sellerInfo.nickname)),
         centerTitle: true,
         leading: IconButton(
           iconSize: 16.px,
           icon: Icon(Icons.arrow_back_ios),
           onPressed: (){
             Get.back();
           },
         ),
       ),
       body: SellerContent(),
     );
  }
}