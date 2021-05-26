import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booksea/ui/widgets/loading_dialog.dart';

extension GetExtension on GetInterface {
  dismiss() {
    if (Get.isDialogOpen) {
      Get.back();
    }
  }

  loading() {
    if (Get.isDialogOpen) {
      Get.back();
    }
    Get.dialog(LoadingDialog(),barrierColor: Colors.transparent);
  }
}
