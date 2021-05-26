import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/profile/suggestion/suggestion.dart';
import 'package:booksea/ui/utils/permission_helper.dart';
import 'package:booksea/ui/shared/app_theme.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/profile/profile_controller.dart';

class ProfileContent extends StatelessWidget {
  ProfileController profileCtl = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Obx(()=>  profileCtl.avatarPath == "" ? Center(child: CircularProgressIndicator()) :
         SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height:40.px),
                  buildHeader(),
                  buildCpn(),
                  SizedBox(height: 12.px,),
                  buildOrderCpn(),
                  SizedBox(height: 12.px,),
                  buildSellCpn(),
                  SizedBox(height: 12.px,),
                  buildMyServiceCpn()
                ],
              )
          ),
        );
  }
}

Widget buildHeader(){
  ProfileController profileCtl = Get.find();
  return Obx(()=>
      Container(
        color: Colors.transparent,
        width: double.infinity,
        height: 100.px,
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(left: 14.px,bottom: 14.px),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                profileCtl.avatarPath,
                width: 70.px,
                height: 70.px,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(child: Text("   "+profileCtl.userName,style: Themes.lightTheme.textTheme.headline1.copyWith(fontSize: 16.px),),),
            TextButton(onPressed: (){
              //弹出bottomSheet
              Get.bottomSheet(
                  Container(
                      height: Get.height / 3,
                      padding: EdgeInsets.only(top: 10.px,left: 20.px,right: 20.px),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            SizedBox(height: 10.px),
                            TextButton(
                              child: Row(children:[
                              Icon(MyIcons.scan,size: 16.px,color: Colors.white,),
                              Text("扫码卖书",style: TextStyle(fontSize: 16.px,color: Colors.white),)
                          ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              onPressed:() async{
                                Get.back();
                                //请求授权处理
                                bool allow = await PermissionHelper.check(
                                    PermissionType.camera,
                                    errMsg: '请授予相机权限',
                                    onErr: () {

                                    },
                                    onSuc: () async {
                                      //跳转到商品发布页面
                                      Get.toNamed(AppPages.QRSCAN, arguments: "publish");
                                    }
                                );
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.px,vertical: 14.px)),
                                foregroundColor: MaterialStateProperty.resolveWith((states) {
                                  //默认状态使用黑色
                                  return Colors.lightBlue;
                                },
                                ),
                                backgroundColor: MaterialStateProperty.resolveWith((states) {
                                  //默认不使用背景颜色
                                  return Colors.lightBlueAccent;
                                }),
                                overlayColor: MaterialStateProperty.all(Colors.transparent),
                              ),
                            ),
                          SizedBox(height: 16.px),
                         Text("手动输入ISBN编码",style: TextStyle(fontSize: 14.px,color: Colors.grey),),
                          SizedBox(height:5.px),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("ISBN：",style: TextStyle(fontSize: 14.px,color: Colors.grey)),
                                SizedBox(width: 5.px),
                                Container(
                                  width: Get.width / 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "请输入978开头的13位ISBN码",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                    ),
                                    onChanged: (val)=>{
                                          profileCtl.changeIsbn(val)
                                    },
                                  ),
                                ),
                                TextButton(
                                  child: Text("确定",style: TextStyle(fontSize: 16.px,color: Colors.white),),
                                  onPressed:(){
                                    Get.back();
                                    Get.toNamed(AppPages.PUBLISH, arguments: profileCtl.isbn);
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.px,vertical: 5.px)),
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      //默认状态使用黑色
                                      return Colors.lightBlue;
                                    },
                                    ),
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      //默认不使用背景颜色
                                      return Colors.lightBlueAccent;
                                    }),
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                  ),
                  backgroundColor: Colors.white, // 底部bottomSheet的背景色
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.px),topRight: Radius.circular(10.px)))
              );
            }, child: Text("卖书",style: TextStyle(fontSize: 14.px),),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20.px)),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                //默认状态使用黑色
                return Colors.black;
              },
              ),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                //设置按下时的背景颜色
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                }
                //默认不使用背景颜色
                return Colors.lightBlue[300];
              }),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.px)))),
            )
            ),
            SizedBox(width: 10.px,)
          ],
        ),
      )
  );
}

Widget buildCpn(){
  ProfileController profileCtl = Get.find();

  TextStyle textStyle =  TextStyle(fontSize: 12.px);
  return Obx(()=>Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5.px))
    ),
    width: Get.width - 20.px,
    height: 60.px,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
          Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.toNamed(AppPages.MYPUBLISH);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(profileCtl.myPublish,style: textStyle,),
                    Text("我发布的",style: textStyle,)
                  ],
                ),
              )
          ),
          Expanded(
              flex: 1,
              child:
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Get.toNamed(AppPages.FOLLOWS, arguments: "myfollows");
                  },
                  child:Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                    Text(profileCtl.authCtl.user.follows.length.toString(),style: textStyle,),
                    Text("我的关注",style: textStyle,)
                ],
              )
          ),
        ),
         Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                    Get.toNamed(AppPages.COLLECTION);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(profileCtl.authCtl.user.collections.length.toString(),style: textStyle,),
                    Text("收藏夹",style: textStyle,)
                  ],
                ),
              )
          ),
      ],
    ),
  ));
}

Widget buildOrderCpn() {
  return Container(
    width: Get.width-20.px,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.px))
    ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("  我的订单",style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.bold),),
                  buildViewAllText((){
                    Get.toNamed(AppPages.ALLORDER);
                  })
                ],
              ),
            ),
            Divider(color: Colors.black12,height: 1,),
            Container(
              child: Wrap(
                children: <Widget>[
                  buildDeliveryItems(MyIcons.toPay,(){
                    Get.toNamed(AppPages.ALLORDER,arguments: "1");
                  },"待付款"),
                  buildDeliveryItems(MyIcons.delivery,(){
                    Get.toNamed(AppPages.ALLORDER,arguments: "2");
                  },"待发货"),
                  buildDeliveryItems(MyIcons.deliveried,(){
                    Get.toNamed(AppPages.ALLORDER,arguments: "3");
                  },"已发货"),
                  buildDeliveryItems(MyIcons.appraise,(){
                    Get.toNamed(AppPages.ALLORDER,arguments: "4");
                  },"待评价"),
                  buildDeliveryItems(MyIcons.refund,(){
                    Get.toNamed(AppPages.ALLORDER,arguments: "5");
                  },"退款/售后"),
                ],
              ),
            ),
          ],
        ),
      );
}

Widget buildSellCpn(){
   return Container(
     width: Get.width-20.px,
     decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(5.px))
     ),
     child: Column(
       children: [
         Container(
           alignment: Alignment.center,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text("  卖的订单",style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.bold),),
               buildViewAllText((){
                 Get.toNamed(AppPages.SELLORDER);
               })
             ],
           ),
         ),
         Divider(color: Colors.black12,height: 1,),
         Container(
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               buildDeliveryItems(MyIcons.toPay,(){
                 Get.toNamed(AppPages.SELLORDER,arguments: "1");
               },"待付款"),
               buildDeliveryItems(MyIcons.delivery,(){
                 Get.toNamed(AppPages.SELLORDER,arguments: "2");
               },"待发货"),
               buildDeliveryItems(MyIcons.deliveried,(){
                 Get.toNamed(AppPages.SELLORDER,arguments: "3");
               },"已发货"),
               buildDeliveryItems(MyIcons.appraise,(){
                 Get.toNamed(AppPages.SELLORDER,arguments: "4");
               },"待评价"),
             ],
           ),
         ),
       ],
     ),
   );
}

Widget buildMyServiceCpn() {
  return Container(
    width: Get.width-20.px,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.px))
    ),
    child: Column(
      children: [
        Container(
          height: 40.px,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("  我的服务",style: TextStyle(fontSize: 12.px,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Divider(color: Colors.black12,height: 1,),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildDeliveryItems(MyIcons.receivingAddress,(){

              },"收货地址"),
              buildDeliveryItems(MyIcons.fans,(){
                  Get.toNamed(AppPages.FOLLOWS, arguments: "myfans");
              },"粉丝"),
              buildDeliveryItems(MyIcons.feedback,(){
                Get.to(Suggestion_view());
              },"意见反馈"),
              buildDeliveryItems(MyIcons.setting,(){
                Get.toNamed(AppPages.SETTING);
              },"设置"),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDeliveryItems(IconData iconData,Function callback,String text){
  return Container(
    padding: EdgeInsets.only(top: 8.px,bottom: 8.px),
    width: (Get.width - 20.px)/4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(iconData,size: 24.px,),
          onPressed: callback,
        ),
        Text(text,style: TextStyle(fontSize: 10.px),)
      ],
    ),
  );
}

Widget buildViewAllText(Function callback){
  return TextButton(
    onPressed: callback,
    child: Text("查看全部>  ",style: TextStyle(fontSize: 10.px,color: Colors.black45),),
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
    ),
  );
}

