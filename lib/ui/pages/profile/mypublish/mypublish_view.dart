import 'package:booksea/core/router/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/profile/mypublish/mypublish_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';

class MyPublishView extends GetView<MyPublishController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
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
      body: Obx(()=> controller.loadState == false ? Center(child: CircularProgressIndicator(),) :
      controller.myPublish.length == 0 ? Center(child: Text("您还没有收藏商品")) :
      ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: controller.myPublish.length,
          itemBuilder: (BuildContext context,int index){
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                Get.toNamed(AppPages.COMMODITY,arguments: controller.myPublish[index].artNo);
              },
              child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 10.px),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(bottom: BorderSide(color: Colors.grey[100]))
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 100.px,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.network(controller.myPublish[index].img,fit:BoxFit.cover),
                                  width: 70.px,
                                  height: 100.px,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[200],blurRadius: 2,spreadRadius: 2)]
                                  ),
                                ),
                                SizedBox(width: 10.px,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.myPublish[index].title,style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w500),),
                                      Text(controller.myPublish[index].author,style: TextStyle(fontSize: 12.px,color: Colors.grey),),
                                      Text(controller.myPublish[index].appearance,style: TextStyle(fontSize: 12.px,color: Colors.grey),),
                                      Text("￥"+controller.myPublish[index].customPrice,style: TextStyle(fontSize: 14.px,color: Colors.redAccent),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 35.px,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                buildButton(text: "编辑",
                                    onPressed: (){
                                      Get.toNamed(AppPages.PUBLISH, arguments: controller.myPublish[index]);
                                    }),
                                SizedBox(width: 8,),
                                buildButton(text: "下架",
                                    onPressed: (){
                                      controller.handleDelPublish(controller.myPublish[index].artNo);
                                    }),
                                SizedBox(width: 12,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          })
      ),
    );
  }
}

Widget buildButton({String text,Function onPressed}){
  return TextButton(
      child: Text(text,style: TextStyle(fontSize: 12.px),),
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          //默认状态使用灰色
          return Colors.black;
        },
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //默认不使用背景颜色
          return Colors.transparent;
        }),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.px)),
            side: BorderSide(color: Colors.black12)
        )),
      )
  );
}

