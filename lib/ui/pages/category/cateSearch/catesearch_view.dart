import 'package:booksea/core/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/category/cateSearch/catesearch_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CateSearchView extends GetView<CateSearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.cateName),
        centerTitle: true,
      ),
      body: Obx(()=> controller.loadState == false ? Center(child: CircularProgressIndicator()) :
          controller.searchList.length == 0 ? Center(child: Text("暂无该类图书出售", style: TextStyle(fontSize: 16.px),)) :
          SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            header: null,
            footer: CustomFooter(
              builder: (BuildContext context,LoadStatus mode){
                Widget body ;
                switch(mode){
                  case LoadStatus.idle : body =  Text("上拉加载"); break;
                  case LoadStatus.loading : body =  CircularProgressIndicator(); break;
                  case LoadStatus.failed : body =  Text("加载失败！点击重试！"); break;
                  case LoadStatus.canLoading : body =  Text("松手,加载更多!"); break;
                  case LoadStatus.noMore : body =  Text("没有更多数据了!"); break;
                }
                return Container(
                  height: 30.0.px,
                  alignment: Alignment.center,
                  child: body,
                );
              },
            ),
            controller: controller.refreshCtl,
            onLoading: (){
              controller.loadBooks(controller.cateName, skipNum: controller.searchList.length);
            },
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.searchList.length,
            itemExtent: 120.px,
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                onTap: (){
                  Get.toNamed(AppPages.BOOK,arguments: controller.searchList[index].isbn);
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
                        child: Image.network(controller.searchList[index].img,
                            width: 70.px,
                            fit:BoxFit.cover),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[200],blurRadius: 2,spreadRadius: 2)]
                        ),
                        height: 110.px,
                      ),
                      SizedBox(width: 8.px,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.searchList[index].title,style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.w500),),
                            Text(controller.searchList[index].author + " | " + controller.searchList[index].publisher,style: TextStyle(fontSize: 10.px,color: Colors.grey),),
                            Text(controller.searchList[index].isbn, style: TextStyle(fontSize: 10.px,color: Colors.grey)),
                            Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(text: controller.searchList[index].minPrice == null ? "":"￥",style: TextStyle(fontSize: 12.px,color: Colors.redAccent)),
                                      TextSpan(text:controller.searchList[index].minPrice ?? "暂无出售",style: TextStyle(fontSize: 12.px,color: Colors.redAccent)),
                                      TextSpan(text: controller.searchList[index].minPrice == null ? "" : " 起",style: TextStyle(fontSize: 10.px,color: Colors.black45)),
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
            }
        ),
      )
      ),
    );
  }
}