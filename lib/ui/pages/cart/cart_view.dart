import 'package:booksea/core/router/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/utils/app_config.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';

class CartView extends StatefulWidget {
  @override
  CartViewState createState() => CartViewState();
}

class CartViewState extends State<CartView> {
  CartController cartCtl = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        toolbarHeight: AppConfig.toolbarHeight,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16.px,
          onPressed: (){
            Get.back();
          },
        ),
      ),
      body:Obx(()=> cartCtl.cartList.length == 0 ? Center(child: Text("购物车空空如也..."),) :
          Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: cartCtl.cartList.length,
                      itemExtent: 160.px,
                      itemBuilder: (BuildContext context,int index){
                        return Container(
                          margin: EdgeInsets.only(left: 10.px,right: 10.px,top: 10.px),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.px))
                          ),
                          child: Column(
                            children: [
                                Expanded(
                                  child: ListTile(leading: ClipOval(
                                    child: Image.network(R.sourceUrl + cartCtl.cartList[index].avatar,width: 30.px,height: 30.px,fit: BoxFit.cover,),
                                  ),
                                    title: Text(cartCtl.cartList[index].nickname+"   >",),
                                    onTap: (){
                                      Get.toNamed(AppPages.SELLER, arguments: cartCtl.cartList[index].userId);
                                    },
                                    contentPadding: EdgeInsets.only(top: 5.px,left: 10.px),
                                  ),
                                ),
                              SizedBox(height: 5.px,),
                              Expanded(
                                flex:3,
                                child: Container(
                                  alignment: Alignment.center,
                                child: Row(
                                  children: [
                                     buildSelectButton(cartCtl.cartList[index].isCheck, (){
                                       cartCtl.changIdxCheck(index);
                                       cartCtl.sum();
                                       setState(() {});
                                     }),
                                    Container(
                                      width: 50.px,
                                      height: 70.px,
                                      color: Colors.white,
                                      child: Image.network(cartCtl.cartList[index].img,fit: BoxFit.cover,),
                                    ),
                                    SizedBox(width: 8.px,),
                                    Expanded(
                                      flex:3,
                                      child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 12.px,),
                                        Text(cartCtl.cartList[index].title,maxLines: 1,overflow: TextOverflow.ellipsis,),
                                        SizedBox(height: 12.px,),
                                        Text(cartCtl.cartList[index].appearance,style: TextStyle(fontSize: 12.px,color: Colors.grey),),
                                        SizedBox(height: 12.px,),
                                        Text("￥"+cartCtl.cartList[index].customPrice,style: TextStyle(fontSize: 14.px,color: Colors.redAccent),)
                                      ],
                                    )),
                                    Expanded(
                                      child: buildOperateBtnCpn(cartCtl.cartList[index].count,minusCallBack: (){
                                     //   cartCtl.sum();
                                    //    cartCtl.minusCommodity(index);
                                        setState(() {});
                                      },addCallBack2: (){
                                     //   cartCtl.addCommodity(index);
                                     //   cartCtl.sum();
                                      },deleCallback: (){
                                        Get.defaultDialog(
                                          title: "",
                                          titleStyle: TextStyle(fontSize: 0),
                                          radius: 10.px,
                                          middleText: "确认要删除选中的商品吗？",
                                          middleTextStyle: TextStyle(fontSize: 14.px),
                                          textConfirm: "确定",
                                          textCancel: "取消",
                                          cancelTextColor: Colors.black87,
                                          confirmTextColor: Colors.lightBlue,
                                          buttonColor: Colors.white,
                                          onConfirm: (){
                                            Get.back();
                                            cartCtl.deCommodity(index);
                                            cartCtl.sum();
                                            setState(() {});
                                          },
                                          onCancel: (){
                                            Get.back();
                                          }
                                        );
                                        setState(() {});
                                      }),
                                    )
                                  ],
                                ),
                              )
                              )
                            ],
                          ),
                        );
                      }
                  )
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                       IconButton(onPressed: (){
                          cartCtl.changAllCheck(!cartCtl.allCheck);
                          setState(() {});
                       }, icon: cartCtl.allCheck == false ? Icon(MyIcons.check_outlined,color: Colors.black54) : Icon(MyIcons.check_filled,color: Colors.lightBlue,)
                       ),
                        Text("全选")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "不含运费",
                              ),
                              TextSpan(
                                text: "合计"
                              ),
                              TextSpan(
                                text: "￥"+ cartCtl.totalPrice.toString(),
                                style: TextStyle(color: Colors.redAccent,fontSize: 16.px)
                              )
                            ]
                          )
                        ),
                        SizedBox(width: 5,),
                        TextButton(onPressed: (){}, child: Text("结算("+cartCtl.checkNum.toString()+")",style: TextStyle(fontSize: 14.px),),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.px,vertical: 5.px)),
                          foregroundColor: MaterialStateProperty.resolveWith((states) {
                            //默认状态
                            return Colors.white;
                          },
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            //默认不使用背景颜色
                            return Colors.lightBlue;
                          }),
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          minimumSize: MaterialStateProperty.all(Size(40.px,20.px)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.px)))
                        ),
                        ),
                        SizedBox(width: 10.px,)
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
      )
    );
  }
}

Widget buildSelectButton(bool isSelected, Function callBack){

  return  IconButton(
      onPressed: (){
         callBack();
      },
      icon: isSelected == false ? Icon(MyIcons.check_outlined,color: Colors.black54,)
          : Icon(MyIcons.check_filled,color: Colors.lightBlue,),
    iconSize: 18.px,
  );
}

//商品数量按钮
Widget buildOperateBtnCpn(int num, {Function minusCallBack, Function addCallBack2,Function deleCallback}){
  Color minusColor = num == 1 ? Colors.grey : Colors.black87;

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      IconButton(onPressed: deleCallback, icon: Icon(MyIcons.dustbin)),
      Container(
        width: 100.px,
        alignment: Alignment.center,
        height: 20.px,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(5.px)
        ),
        child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Expanded(
                    child: TextButton(
                        onPressed: minusCallBack,
                        child: Text("-",style: TextStyle(fontSize: 12.px),),
                        style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(bottom: 3.px)),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        foregroundColor: MaterialStateProperty.resolveWith((states) {
                          //默认状态
                          return minusColor;
                        },
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          //默认不使用背景颜色
                          return Colors.transparent;
                        }),
                        minimumSize: MaterialStateProperty.all(Size(8.px,8.px)),
                      ),
                    ),
                  ),
                Expanded(child: Container(
                  color:Colors.grey[400],
                  alignment: Alignment.center,
                    child: Text(num.toString(),style: TextStyle(fontSize: 10.px),))),
                Expanded(
                    child:TextButton(
                      onPressed: addCallBack2,
                      child: Text("+",style: TextStyle(fontSize: 12.px),),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(bottom: 3.px)),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        foregroundColor: MaterialStateProperty.resolveWith((states) {
                          return Colors.black87;
                        },
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          //默认不使用背景颜色
                          return Colors.transparent;
                        }),
                        minimumSize: MaterialStateProperty.all(Size(8.px,8.px)),
                      ),
                    )
                )
          ],
        ),
      ),
    ],
  );
}

