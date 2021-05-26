import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/pages/home/search/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 16.px,
                onPressed: (){
                  Get.back();
                },
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    height: 32.px,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(30.px)
                    ),
                    padding: EdgeInsets.only(left: 10.px),
                    width: Get.width - 80.px,
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(MyIcons.search,color: Colors.black45,),
                        hintText: "输入书名/ISBN",
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      ),
                      textAlignVertical: TextAlignVertical.bottom,
                      textAlign: TextAlign.left,
                      autofocus: true,
                      onChanged: (value){
                        controller.changSearch(value);
                      },
                    )
                ),
              ),
              SizedBox(width: 5.px,),
              ElevatedButton(
                onPressed: (){
                  controller.handleSearch(controller.search);
                },
                child: Text("搜索"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blueAccent,width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(30.px))))
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 0.px,
        leading: Text(""),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: Obx(()=>controller.searchBooks.length == 0 ?
          Center(child: Text("搜一搜"),):
          ListView.builder(
              itemExtent: 100.px,
              itemCount: controller.searchBooks.length,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(AppPages.BOOK,arguments: controller.searchBooks[index].isbn);
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
                          child: Image.network(controller.searchBooks[index].img,
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
                              Text(controller.searchBooks[index].title,style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.w500),),
                              Text(controller.searchBooks[index].author + " | " + controller.searchBooks[index].publisher,style: TextStyle(fontSize: 10.px,color: Colors.grey),),
                              Text(controller.searchBooks[index].isbn, style: TextStyle(fontSize: 10.px,color: Colors.grey)),
                              Text.rich(
                                  TextSpan(
                                      children: [
                                        TextSpan(text: controller.searchBooks[index].minPrice == null ? "":"￥",style: TextStyle(fontSize: 12.px,color: Colors.redAccent)),
                                        TextSpan(text:controller.searchBooks[index].minPrice ?? "暂无出售",style: TextStyle(fontSize: 12.px,color: Colors.redAccent)),
                                        TextSpan(text: controller.searchBooks[index].minPrice == null ? "" : " 起",style: TextStyle(fontSize: 10.px,color: Colors.black45)),
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
          )
          )
              )
        ],
      ),
    );
  }
}