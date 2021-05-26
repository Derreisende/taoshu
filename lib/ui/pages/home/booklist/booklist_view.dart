import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/home/booklist/booklist_controller.dart';
import 'package:booksea/core/router/app_pages.dart';
import '../widgets.dart';

class BookListView extends GetView<BookListController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("热门书单"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16.px,
          onPressed: (){
            Get.back();
          },
        ),
      ),
      body: GridView.count(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1,
          children: List<Widget>.from(controller.booklists.map((listItem){
            return buildBookItem(listItem.cover, listItem.listName, ()=>{
              Get.toNamed(AppPages.LISTDETAIL, arguments: listItem.listName)
            });
          })
          )
      ),
    );
  }
}

