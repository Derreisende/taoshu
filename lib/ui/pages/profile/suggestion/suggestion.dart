import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/extension/num_extension.dart';

class Suggestion_view extends GetView<SuggestionController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("意见反馈"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 16.px,
            onPressed: (){
              Get.back();
            },
          ),
          shape: Border(bottom: BorderSide(color: Colors.grey[200])),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal:10.px,vertical: 5.px),
                width: double.infinity,
                child:TextField(
                        maxLines: 10,
                        style: TextStyle(fontSize: 14.px),
                        decoration: InputDecoration(
                          hintText: "描述您遇到的问题",
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        ),
                        onChanged: (value){

                        }
                ),
              ),
               SizedBox(height: 10.px,),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 5.px),
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Text("联系方式",style: TextStyle(fontSize: 15.px),),
                    SizedBox(width: 10,),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 14.px),
                        decoration: InputDecoration(
                          hintText: "电话、QQ或微信",
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        ),
                        onChanged: (value){

                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.px,),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 10.px),
                child: TextButton(
                  child: Text("提交",style: TextStyle(fontSize: 14.px),),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.px,vertical: 5.px)),
                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                        //默认状态
                        return Colors.white;
                      },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        //默认不使用背景颜色
                        return Colors.redAccent;
                      }),
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      minimumSize: MaterialStateProperty.all(Size(Get.width-40.px,40.px)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.px)))
                  ),
                  onPressed: (){

                  },
                ),
              )
            ])
    )
    );
  }
}

class SuggestionController extends GetxController {


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
    super.onClose();
  }
}