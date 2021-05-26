import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';

Widget myDialog({
  Widget content,
  Function onCancel,
  Function onConfirm
}){
  return Center(
    child: Container(
      width: Get.width/1.4,
      height: 120.px,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.px))
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: content
            ),
          ),
          Divider(height: 1,color: Colors.grey[300],),
          Container(
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8.px),
                          child: Text("取消",style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.w500),)
                      ),
                      onTap: onCancel,
                    )
                ),
                Expanded(
                  child:GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.px)),
                          color: Colors.lightBlueAccent,
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8.px),
                        child: Text("确定",style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.w500)
                        )
                    ),
                    onTap: onConfirm,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}