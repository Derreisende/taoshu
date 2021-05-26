import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booksea/core/extension/num_extension.dart';

//书单小组件
Widget buildBookItem(String img,String text,Function callback){
  return TextButton(
    onPressed: callback,
    child: Container(
      width: Get.width/2 - 20.px,
      height: 150.px,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.px),
            child: Image.network(
              img,fit: BoxFit.cover,
              width: 120.px,
              height: 100.px,
            ),
          ),
          SizedBox(height: 6.px,),
          Expanded(child: Text(text,style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.w500,color: Colors.black),))
        ],
      ),
    ),
    style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent)
    ),
  );
}