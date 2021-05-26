import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/profile/sellOrderManage/sell_order_controller.dart';

class SellOrderDetailView extends GetView<SellOrderController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("你还没有相关的订单"),
    );
  }
}
