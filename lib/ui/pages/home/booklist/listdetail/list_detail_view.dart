import 'package:booksea/core/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'list_detail_controller.dart';

class ListDetailView extends GetView<ListDetailController>{
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(()=>
      controller.listContents.length == 0 ? Center(child: CircularProgressIndicator()) :
          CustomScrollView(
            controller: controller.scrollCtl,
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 150.px,
                backgroundColor: Colors.white,
                leading: IconButton(
                  iconSize: 16.px,
                  splashRadius: 14.px,
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: (){
                    Get.back();
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(controller.title, style: TextStyle(color: Colors.black87,fontSize: 16.px),),
                  centerTitle: true,
                  background: Image.network(controller.listContents[0].cover,fit: BoxFit.cover,),
                ),
              ),

              SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                    return GestureDetector(
                      onTap: (){
                          Get.toNamed(AppPages.BOOK, arguments: controller.listContents[index].isbn);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 8.px),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(bottom: BorderSide(color: Colors.grey[100]))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.network(controller.listContents[index].img,
                                  width: 60.px,
                                  fit:BoxFit.cover),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[200],blurRadius: 2,spreadRadius: 2)]
                              ),
                              height: 90.px,
                            ),
                            SizedBox(width: 8.px,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.listContents[index].title,style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.w500),),
                                  Text(controller.listContents[index].author + " | " + controller.listContents[index].publisher,style: TextStyle(fontSize: 10.px,color: Colors.grey),),
                                  Text(controller.listContents[index].isbn, style: TextStyle(fontSize: 10.px,color: Colors.grey)),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: "￥",style: TextStyle(fontSize: 12.px,color: Colors.redAccent)),
                                        TextSpan(text:controller.listContents[index].minPrice ?? "暂无出售",style: TextStyle(fontSize: 12.px,color: Colors.redAccent)),
                                        TextSpan(text: controller.listContents[index].minPrice == null ? "" : " 起",style: TextStyle(fontSize: 10.px,color: Colors.black45)),
                                      ]
                                    )
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                      childCount: controller.listContents.length
                  ),
                  itemExtent: 100.px
              )
            ],
          ),
      )
    );
  }
}