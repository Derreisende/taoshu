import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/pages/cart/cart_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/book/book_controller.dart';

class BookView extends GetView<BookController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(()=>Text(controller.title)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16.px,
          onPressed: (){
            Get.back();
          },
        ),
      ),
      body: Obx(() => controller.bookInfo.isbn == null ? Center(child: CircularProgressIndicator(),) :
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                width: double.infinity,
                height: Get.height / 3.5,
                color: Colors.white,
                child: Image.network(controller.bookInfo.img),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.px, bottom: 5.px),
                color: Colors.white,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(controller.bookInfo.title,style: TextStyle(fontSize: 18.px,fontWeight: FontWeight.bold),),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 10.px),
                width: double.infinity,
                child: Column(
                  children: [
                    buildInfoItem("作者", controller.bookInfo.author),
                    SizedBox(height: 5.px),
                    buildInfoItem("出版社", controller.bookInfo.publisher),
                    SizedBox(height: 5.px),
                    buildInfoItem("出版时间", controller.bookInfo.pubdate),
                    SizedBox(height: 5.px),
                    buildInfoItem("ISBN", controller.bookInfo.isbn),
                    SizedBox(height: 5.px),
                    buildInfoItem("定价", controller.bookInfo.price),
                    SizedBox(height: 5.px),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Get.bottomSheet(
                          buildBottomSheet(),
                          backgroundColor: Colors.white, // 底部bottomSheet的背景色
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.px),topRight: Radius.circular(10.px)))
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("出版信息",style: TextStyle(fontSize: 14.px),),
                          Icon(Icons.arrow_forward_ios, size: 14.px,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5.px),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.px,horizontal: 8.px),
                color: Colors.white,
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Get.bottomSheet(
                            Container(
                                height: Get.height / 3,
                                padding: EdgeInsets.only(top: 10.px,left: 10.px,right: 8.px),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text("内容简介", style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.bold)),
                                      SizedBox(height: 14.px),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text("     "+controller.bookInfo.gist)
                                          ,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            backgroundColor: Colors.white, // 底部bottomSheet的背景色
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.px),topRight: Radius.circular(10.px)))
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("内容简介",style: TextStyle(fontSize: 16.px),),
                          Icon(Icons.arrow_forward_ios, size: 14.px,)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.px),
                    Text(controller.bookInfo.gist,
                      style: TextStyle(fontSize: 13.px, color: Colors.black54),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.px),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10.px),
                child: Column(
                  children: [
                    SizedBox(height:10.px),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("在售商品",style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.bold),),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: controller.commoList.length.toString(),style: TextStyle(fontSize: 16.px, color: Colors.lightBlue)),
                              TextSpan(text:" 件",style: TextStyle(fontSize: 12.px))
                            ]
                          )
                        )
                      ],
                    ),
                    SizedBox(height:10.px),
                    Divider(thickness: 1,),
                    Column(
                          children: controller.commoList.length == 0? <Widget>[SizedBox(height: 50.px)] :
                          List<Widget>.from(controller.commoList.map((element){
                           return buildCommodityItem(element, (){
                             Get.toNamed(AppPages.COMMODITY, arguments: element.artNo);
                            });
                          })),
                        )
                  ],
                ),
              )
            ],
      ),)
    );
  }
}

Widget buildInfoItem(String title,String text){
  return Row(
      children: [
        Expanded(flex: 1,child: Text(title, style: TextStyle(color: Colors.black54, fontSize: 14.px))),
        Expanded(flex: 2,child: Text(text, style: TextStyle(fontSize: 14.px))),
      ],
    );
}

Widget buildBottomSheet(){
  BookController bookCtl = Get.find<BookController>();
  return Obx(()=>
      Container(
        height: Get.height / 2,
        padding: EdgeInsets.only(top: 10.px,left: 10.px,right: 8.px),
        child: Column(
          children: [
            Text("出版信息", style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.w400),),
            SizedBox(height: 10.px),
            buildInfoItem("书名", bookCtl.bookInfo.title),
            SizedBox(height: 5.px),
            buildInfoItem("作者", bookCtl.bookInfo.author),
            SizedBox(height: 5.px),
            buildInfoItem("出版社", bookCtl.bookInfo.publisher),
            SizedBox(height: 5.px),
            buildInfoItem("出版时间", bookCtl.bookInfo.pubdate),
            SizedBox(height: 5.px),
            buildInfoItem("ISBN", bookCtl.bookInfo.isbn),
            SizedBox(height: 5.px),
            buildInfoItem("定价", bookCtl.bookInfo.price),
            SizedBox(height: 5.px),
            buildInfoItem("版次", bookCtl.bookInfo.edition),
            SizedBox(height: 5.px),
            buildInfoItem("装帧", bookCtl.bookInfo.binding),
            SizedBox(height: 5.px),
            buildInfoItem("开本", bookCtl.bookInfo.format),
            SizedBox(height: 5.px),
            buildInfoItem("分类", bookCtl.bookInfo.firstCategory),
            Expanded(child: Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: (){
                  Get.back();
                },
                child: Text("完成",style: TextStyle(fontSize: 14.px),),
                style:  ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    //默认状态使用白色
                    return Colors.white;
                  },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    //默认不使用背景颜色
                    return Colors.lightBlue;
                  }),
                  minimumSize: MaterialStateProperty.all(Size(Get.width-20.px,36.px)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.px)))),
                ),
              ),
            )),
            SizedBox(height: 8.px,)
          ],
        ),
      )
  );
}

Widget buildCommodityItem(element, Function callBack){
  return GestureDetector(
    onTap: callBack,
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
            child: Image.network(element.img,fit:BoxFit.cover),
            width: 50.px,
            height: 90.px,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[200],blurRadius: 2,spreadRadius: 2)]
            ),
          ),
          SizedBox(width: 5.px,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(element.title,style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.w500),),
                SizedBox(height: 10.px),
                Row(
                  children: [
                    Text("￥"+element.customPrice,style: TextStyle(fontSize: 16.px,color: Colors.redAccent),),
                    SizedBox(width: 10.px),
                    Text(element.appearance,style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.w200),),
                    SizedBox(width: 10.px),
                    Text("快递"+element.freight+"元",style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.w200),)
                  ],
                ),
                SizedBox(height: 10.px),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){Get.toNamed(AppPages.SELLER,arguments: element.userId);},
                  child: Row(children: [
                    ClipOval(child: Image.network(R.sourceUrl+element.avatar,width: 16.px,height: 16.px,),),
                    Text("  "+element.nickname,style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.w300),)
                  ],),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: (){
                CartController cartCtl = Get.find<CartController>();
                AuthController authCtl = Get.find<AuthController>();
                authCtl.ifAuth();
                if(authCtl.isLog){
                  Map<String,dynamic> cartJson = element.toJson();
                  cartJson["isCheck"] = false;
                  cartJson['count'] = 1;
                  cartCtl.addCart(cartCtl.cartList, CartModel.fromJson(cartJson));
                }
              },
              icon: Icon(MyIcons.cart_add,color: Colors.deepOrangeAccent,size: 16.px,)
          )
        ],
      ),
    ),
  );
}