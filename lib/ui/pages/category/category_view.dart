import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/pages/category/category_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/utils/app_config.dart';
import 'category_controller.dart';

class CategoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryController cateCtl = Get.find<CategoryController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("分类"),
        toolbarHeight: AppConfig.toolbarHeight,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16.px,
          onPressed: (){
            Get.back();
          },
        ),
        //  actionsIconTheme: IconThemeData(color: Colors.black45),
      ),
      body: Obx(()=> cateCtl.category.length == 0 ? Center(child: CircularProgressIndicator()) :
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
           Expanded(
           flex: 2,
           child: Container(
             color: Colors.white,
             child: ListView.builder(
               itemCount: cateCtl.category.length,
               itemBuilder: (BuildContext context, int position) {
                 return getRow(position);
               },
             ),
           ),
         ),
        SizedBox(width: 6.px),
        Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(top: 10.px),
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 10.px),
              child: getChip(cateCtl.tabIndex),
            )
        )
         ]
    )
      )
    );
  }
}

//左侧选项卡
Widget getRow(int i) {
  CategoryController cateCtl = Get.find<CategoryController>();
  return Obx(()=>GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      //Container下的color属性会与decoration下的border属性冲突，所以要用decoration下的color属性
      decoration: BoxDecoration(
        color: cateCtl.tabIndex == i ? Colors.grey[100] : Colors.white,
        border: Border(
          left: BorderSide(
              width: 5,
              color: cateCtl.tabIndex == i ? Colors.grey : Colors.white),
        ),
      ),
      child: Text(cateCtl.category[i].firstCategory,
        style: TextStyle(
          color: cateCtl.tabIndex == i ? Colors.black : Colors.black54,
          fontWeight: cateCtl.tabIndex == i ? FontWeight.w500 : FontWeight.w400,
          fontSize: 14.px,
        ),
      ),
    ),
    onTap: () {
      cateCtl.changeTabIdx(i);
    },
  ));
}

Widget getChip(int i) {
  //更新对应下标数据
  CategoryController cateCtl = Get.find<CategoryController>();
  return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 0.5,
      children: List<Widget>.generate(cateCtl.category[i].secondCategory.length,(index){
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            Get.toNamed(AppPages.CATESEARCH, arguments: cateCtl.category[i].secondCategory[index].cateName);
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 70.px,
                  child: Image.network(cateCtl.category[i].secondCategory[index].cateImg,fit: BoxFit.cover,)
                ),
                Text(cateCtl.category[i].secondCategory[index].cateName)
              ],
            ),
          ),
        );
      }
).toList(),
);
}