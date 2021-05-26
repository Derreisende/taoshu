import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/profile/orderManage/order_controller.dart';

class OrderDetailView extends GetView<OrderController> {

  @override
  Widget build(BuildContext context) {
      return Center(
        child: Text("你还没有相关的订单"),
      );
  }
}
