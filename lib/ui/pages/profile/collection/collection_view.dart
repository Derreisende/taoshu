import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/profile/collection/collection_controller.dart';

class CollectionView extends GetView<CollectionController>{
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
        controller.collections.length == 0 ? Center(child: Text("您还没有收藏商品")) :
            ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: controller.collections.length,
                itemExtent: 110.px,
                itemBuilder: (BuildContext context,int index){
                   return GestureDetector(
                     behavior: HitTestBehavior.opaque,
                     onTap: (){
                       Get.toNamed(AppPages.COMMODITY, arguments: controller.collections[index].artNo);
                     },
                     onLongPress: (){
                       Get.dialog(
                         Center(
                           child: GestureDetector(
                             onTap: (){
                               controller.handleDelCollection(controller.collections[index].artNo);
                               Get.back();
                             },
                             child: Container(
                               padding: EdgeInsets.symmetric(vertical: 5.px),
                               color: Colors.white,
                               alignment: Alignment.center,
                               height: 40.px,
                               width: Get.width / 1.5,
                               child: Text("删除",style: TextStyle(fontSize: 14.px,color: Colors.red,fontWeight: FontWeight.w500),),
                             ),
                           ),
                         )
                       );
                     },
                     child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 8.px),
                       decoration: BoxDecoration(
                           color: Colors.white,
                           border: Border(bottom: BorderSide(color: Colors.grey[100]))
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Container(
                             child: Image.network(controller.collections[index].img,fit:BoxFit.cover),
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
                                 Text(controller.collections[index].title,style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w500),),
                                 Text(controller.collections[index].author,style: TextStyle(fontSize: 12.px,color: Colors.grey),),
                                 Text("￥"+controller.collections[index].customPrice,style: TextStyle(fontSize: 14.px,color: Colors.redAccent),),
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