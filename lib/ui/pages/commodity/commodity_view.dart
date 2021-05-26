import 'package:flui/flui.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/pages/cart/cart_model.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/commodity/commodity_controller.dart';

class CommodityView extends GetView<CommodityController> {
  AuthController authController = Get.find<AuthController>();
  CartController cartCtl = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16.px,
          onPressed: (){
            Get.back();
          },
        ),
        title: Text("商品详情"),
        centerTitle: true,
      ),
      body: Obx(()=> controller.commodity.artNo == null ? Center(child: CircularProgressIndicator()) :
          Column(
        children: [
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: Get.height / 3,
                  child: Image.network(controller.commodity.img, fit: BoxFit.contain,),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.px,vertical: 14.px),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(controller.commodity.title, style: TextStyle(fontSize: 20.px,fontWeight: FontWeight.normal),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("￥"+controller.commodity.customPrice, style: TextStyle(fontSize: 16.px,color: Colors.redAccent),),
                          Text(controller.commodity.deliveryLocation,style: TextStyle(fontSize: 14.px,color: Colors.black45),)
                        ],
                      ),
                      Text(controller.commodity.appearance,style: TextStyle(fontSize: 14.px,color: Colors.black45))
                    ],
                  )
                ),
                SizedBox(height: 6.px),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.px,vertical: 12.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("商品信息",style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.normal),),
                      SizedBox(height: 10.px,),
                      buildInfoItem("作者", controller.commodity.author),
                      buildInfoItem("出版社", controller.commodity.publisher),
                      buildInfoItem("出版时间", controller.commodity.pubdate),
                      buildInfoItem("版次", controller.commodity.edition),
                      buildInfoItem("装帧", controller.commodity.binding),
                      buildInfoItem("货号", controller.commodity.artNo),
                    ],
                  ),
                ),
                SizedBox(height: 6.px),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.px,vertical: 10.px),
                  child: Row(
                    children: [
                      Text("运费",style: TextStyle(fontSize: 14.px,color: Colors.black45)),
                      SizedBox(width: 10.px,),
                      Text("快递￥"+controller.commodity.freight+"元",style: TextStyle(fontSize: 14.px,color: Colors.black87)),
                    ],
                  ),
                ),
                SizedBox(height: 8.px),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12.px),
                  child: Column(
                    children: [
                      SizedBox(height: 8.px),
                      Row(children: [
                        Text("评价",style: TextStyle(fontSize: 16.px,fontWeight: FontWeight.w400),),
                        SizedBox(width: 6.px),
                        Text(controller.commodity.evaluation.length.toString(),style: TextStyle(color: Colors.black45,fontSize: 14.px),)
                      ],),
                      SizedBox(height: 8.px),
                      Divider(color: Colors.grey[200],thickness: 1,height: 1,),
                      controller.commodity.evaluation.length == 0 ? SizedBox(height: 50.px,) :
                       Column(
                         children: List<Widget>.from(controller.commodity.evaluation.map((e){
                           return Container(
                             padding: EdgeInsets.only(bottom: 10.px),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 ListTile(
                                   leading: ClipOval(child: Image.network(R.sourceUrl+e.avatar,width: 16.px,height: 16.px,)),
                                   title: Text(e.nickname),
                                 ),
                                 Text(e.comments)
                               ],
                             ),
                           );
                         })),
                       )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: Get.width,
            height: 50.px,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildIcon(Icon(MyIcons.seller,size: 20.px,color: Colors.black87,), (){
                   Get.toNamed(AppPages.SELLER, arguments: controller.commodity.userId);
                  }, "卖家"),
                buildIcon(Icon(controller.isCollect ==false ? MyIcons.star_outlined :
                    MyIcons.star_filled,size: 20.px,color: Colors.black87), (){
                    controller.handleCollect(controller.commodity.artNo);
                  }, "收藏"),
                buildIcon(FLBadge(child: Icon(MyIcons.shopping_cart_outlined,size: 20.px,color: Colors.black87),
                  hidden: authController.showBadge.value,
                  text: cartCtl.cartList.length.toString(),
                  textStyle: TextStyle(color: Colors.white,fontSize: 8.px),
                ), (){
                    Get.toNamed(AppPages.CART);
                  }, "购物车"),
                controller.currentUserId == false ?
                Row(
                    children: [
                      TextButton(onPressed: (){
                        CartController cartCtl = Get.find<CartController>();
                        AuthController authCtl = Get.find<AuthController>();
                        authCtl.ifAuth();
                        if(authCtl.isLog){
                          Map<String,dynamic> cartJson = controller.commodity.toJson();
                          cartJson["isCheck"] = false;
                          cartJson['count'] = 1;
                          cartCtl.addCart(cartCtl.cartList, CartModel.fromJson(cartJson));
                        }
                      }, child: Text("加入购物车", style: TextStyle(fontSize: 12.px),),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.resolveWith((states) {
                            //默认状态使用灰色
                            return Colors.white;
                          },
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            return Colors.deepOrangeAccent;
                          }),
                          minimumSize: MaterialStateProperty.all(Size(40.px,40.px)),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.px)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(5.px),bottomLeft: Radius.circular(5.px)))),
                        ),
                      ),
                      TextButton(onPressed: (){

                      }, child: Text("立即购买",style: TextStyle(fontSize: 12.px)),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.resolveWith((states) {
                            //默认状态使用灰色
                            return Colors.white;
                          },
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            return Colors.redAccent;
                          }),
                          minimumSize: MaterialStateProperty.all(Size(40.px,40.px)),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.px)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(5.px),bottomRight: Radius.circular(5.px)))),
                        ),
                      )
                    ],
                  ) :  Container(
                  width: Get.width / 2,
                  height: 40.px,
                    child: TextButton(onPressed: (){
                    Get.toNamed(AppPages.MYPUBLISH);
                }, child: Text("管理",style: TextStyle(fontSize: 12.px)),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                        //默认状态使用灰色
                        return Colors.white;
                      },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.lightBlue;
                      }),
                      minimumSize: MaterialStateProperty.all(Size(40.px,80.px)),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.px)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.px)))),
                    ),
                ),
                  )
              ],
            ),
          )
        ],
      ),)
    );
  }
}

Widget buildIcon(Widget icon,Function callBack,String text,{Color color}){
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: callBack,
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: icon),
          Expanded(child: Text(text, style: TextStyle(fontSize: 10.px,color: Colors.black87),))
        ],
      ),
    ),
  );
}

Widget buildInfoItem(String title, String text){
  return Row(
    children: [
      Expanded(child: Text(title,style: TextStyle(fontSize: 14.px,color: Colors.black45))),
      Expanded(flex:2,child: Text(text,style: TextStyle(fontSize: 14.px),))
    ]
  );
}