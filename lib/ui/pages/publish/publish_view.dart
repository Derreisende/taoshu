import 'dart:convert';
import 'package:booksea/core/router/app_pages.dart';
import 'package:flui/flui.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/ui/widgets/Picker.dart';
import 'package:booksea/ui/pages/publish/publish_controller.dart';
import 'package:booksea/core/extension/num_extension.dart';

class PublishView extends GetView<PublishController>{
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: buildLeadingBtn((){
            Get.back();
        }),
        leadingWidth: 60.px,
        actions: [
          buildActionBtn((){
            controller.handlePublish(artNo:controller.artNo,isbn:controller.isbn,customPrice: controller.customPrice,
            freight: controller.freight,appearance: controller.appearance,firstCategory: controller.firstCategory,
              secondCategory: controller.secondCategory,deliveryLocation: controller.deliveryLocation
            );
            Get.offAllNamed(AppPages.MAIN);
          })
        ],
      ),
      body: Obx(()=> controller.bookInfo.isbn == null ? Center(child: CircularProgressIndicator()) :
        Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 15.px),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.network(controller.bookInfo.img, width: 70.px, fit:BoxFit.cover),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[200],blurRadius: 2,spreadRadius: 2)]
                      ),
                      height: 100.px,
                    ),
                    SizedBox(width: 14.px,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.bookInfo.title,style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w500),),
                          Text("ISBN："+controller.bookInfo.isbn, style: TextStyle(fontSize: 12.px,color: Colors.grey)),
                          Text("作者："+controller.bookInfo.author,style: TextStyle(fontSize: 12.px,color: Colors.grey),),
                          Text("出版社："+controller.bookInfo.publisher,style: TextStyle(fontSize: 12.px,color: Colors.grey)),
                          Text("原价："+controller.bookInfo.price,style: TextStyle(fontSize: 12.px,color: Colors.grey))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.px),
              Expanded(
                    child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.white,
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 15.px),
                                  height: 50.px,
                                  child: Text("出售信息",style: TextStyle(fontSize: 18.px),)),
                              Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    FLListTile(
                                      title: Text('售价￥'),
                                      trailing: buildTextField(
                                          controller: controller.priceCtl,
                                          hintText: "请输入出售价格",
                                          callback: (value){
                                        controller.setCustomPrice(value);
                                      }),
                                      backgroundColor: Colors.white,
                                    ),
                                    FLListTile(
                                      title: Text('运费￥'),
                                      trailing: buildTextField(
                                          controller: controller.freightCtl,
                                          hintText: "请输入运费",
                                          callback: (value){
                                        controller.setFreight(value);
                                      }),
                                      backgroundColor: Colors.white,
                                    ),
                                    FLListTile(
                                      title: Text('数量'),
                                      trailing: Text('1'),
                                      backgroundColor: Colors.white,
                                    ),
                                    FLListTile(
                                      title: Text('新旧'),
                                      trailing: Text.rich(TextSpan(
                                          children: [
                                            TextSpan(text: controller.appearance),
                                            TextSpan(text: "   >",style: TextStyle(color: Colors.grey,fontSize: 16.px))
                                          ]
                                      )),
                                      backgroundColor: Colors.white,
                                      onTap: (){
                                        R.hideKeyBoard(context);
                                        var pickAppearance = ["全新","九成新","八成新","七成新","六成新"];
                                          PickHelper.openSimpleDataPicker(context, list: pickAppearance, value: "全新", onConfirm: (index,value){
                                            controller.setAppearance(value);
                                          });
                                      },
                                    ),
                                    FLListTile(
                                      title: Text('请选择分类'),
                                      trailing: Text.rich(TextSpan(
                                          children: [
                                            TextSpan(text: controller.firstCategory +"   "+ controller.secondCategory),
                                            TextSpan(text: "   >",style: TextStyle(color: Colors.grey,fontSize: 16.px))
                                          ]
                                      )),
                                      backgroundColor: Colors.white,
                                      onTap: (){
                                        R.hideKeyBoard(context);
                                        PickHelper.openCategoryPicker(context, onConfirm: (data, selecteds){
                                          controller.setFirstCategory(data[0]);
                                          controller.setSecondCategory(data[1]);
                                        });
                                      },
                                    ),
                                    FLListTile(
                                      title: Text('发货地'),
                                      trailing: Text.rich(TextSpan(
                                        children: [
                                          TextSpan(text: controller.deliveryLocation),
                                          TextSpan(text: "   >",style: TextStyle(color: Colors.grey,fontSize: 16.px))
                                        ]
                                      )),
                                      backgroundColor: Colors.white,
                                      onTap: (){
                                        R.hideKeyBoard(context);
                                        PickHelper.openCityPicker(context, onConfirm: (data, index){
                                          String province = data[0].substring(0,data[0].length-1);
                                          String city = data[1].substring(0,data[1].length-1);
                                          controller.setDeliveryLocation(province+city);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                  )
              )
            ],
        ),
      )
    );
  }
}

Widget buildTextField({TextEditingController controller,String hintText,ValueChanged<String> callback }){
  return Container(
    width: Get.width / 2,
    child: TextField(
      controller: controller,
      autofocus: false,
      decoration: InputDecoration(
          hintText: "请输入" + hintText,
          hintStyle: TextStyle(color: Colors.grey),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
      ),
      onChanged: callback,
    ),
  );
}

//取消按钮
Widget buildLeadingBtn(Function callback){
  return TextButton(
    child: Text("取消",style: TextStyle(fontSize: 14.px),),
    onPressed:callback,
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        //默认状态使用黑色
        return Colors.black;
      },
      ),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //默认不使用背景颜色
        return Colors.transparent;
      }),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.px)))),
    ),
  );
}

//发布按钮
Widget buildActionBtn(Function callback){
  return TextButton(
    child: Text("发布",style: TextStyle(fontSize: 14.px),),
    onPressed:callback,
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.px,vertical: 5.px)),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        //默认状态使用黑色
        return Colors.lightBlue;
      },
      ),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        //默认不使用背景颜色
        return Colors.transparent;
      }),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
  );
}
