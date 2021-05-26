import 'package:booksea/core/router/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/ui/pages/seller/seller_controller.dart';

class SellerContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SellerController sellerCtl = Get.find<SellerController>();
    return Obx(()=> sellerCtl.sellerInfo.userId == null ? Center(child: CircularProgressIndicator(),):
    CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate(
                [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 20.px,left: 10.px,right: 10.px,bottom: 10.px),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipOval(
                                child: Image.network(R.sourceUrl + sellerCtl.sellerInfo.avatar,fit: BoxFit.cover,width: 70.px,height: 70.px,),
                              ),
                              SizedBox(height: 15.px,),
                              Text(sellerCtl.sellerInfo.nickname,style: TextStyle(fontSize: 14.px),)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                buildTextItem(sellerCtl.sellerInfo.bookSelled.length.toString(),"在售商品"),
                                buildTextItem(sellerCtl.sellerInfo.follows.length.toString(), "关注"),
                                buildTextItem(sellerCtl.sellerInfo.fans.length.toString(), "粉丝")
                              ],
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              ),
                              sellerCtl.isMe == true ?
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 24.px),
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: (){
                                    Get.toNamed(AppPages.EDITUSERINFO);
                                  },
                                  child: Text("编辑资料",style: TextStyle(fontSize: 14.px),),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40.px,vertical: 5.px)),
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      return Colors.black87;
                                    },
                                    ),
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      return Colors.transparent;
                                    }),
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15.px)),
                                        side: BorderSide(color: Colors.black87)
                                    )),
                                  ),
                                ),
                              )
                                  :
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 24.px),
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: (){
                                  sellerCtl.handleFollow(sellerCtl.sellerInfo.userId);
                                },
                                  child: Text("+ 关注",style: TextStyle(fontSize: 14.px),),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40.px,vertical: 5.px)),
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      return Colors.black87;
                                    },
                                    ),
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if(sellerCtl.sellerInfo.isFollow != null){
                                        return sellerCtl.sellerInfo.isFollow == true ? Colors.grey : Colors.lightBlue;
                                      }
                                        return Colors.lightBlue;
                                    }),
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.px)))),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15.px,vertical: 10.px),
                    child: Text(sellerCtl.sellerInfo.summary,style: TextStyle(fontSize: 12.px),),
                  ),
                  SizedBox(height: 10.px),
                ]
            )
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  Get.toNamed(AppPages.COMMODITY,arguments: sellerCtl.sellerInfo.bookSelled[index].artNo);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.px),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 10.px,),
                      Expanded(
                        flex:3,
                        child: Container(
                          width: Get.width / 3 - 50.px,
                          height: 100.px,
                          child: Image.network(sellerCtl.sellerInfo.bookSelled[index].img,
                            fit: BoxFit.cover,),
                        ),
                      ),
                      SizedBox(height: 10.px,),
                      Expanded(
                          child: Text(sellerCtl.sellerInfo.bookSelled[index].title,style: TextStyle(fontSize: 12.px),)),
                      Expanded(child: Text("￥"+sellerCtl.sellerInfo.bookSelled[index].customPrice,style: TextStyle(fontSize: 14.px,color: Colors.deepOrangeAccent),))
                    ],
                  ),
                ),
              );
            },
            childCount: sellerCtl.sellerInfo.bookSelled.length
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.px,
              crossAxisSpacing: 10.px,

            )
        )
      ],
    )
    );
  }
}

Widget buildTextItem(String topText, String bottomText){
  return Container(
    height: 30.px,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(topText,style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w400),)),
        Expanded(child: Text(bottomText,style: TextStyle(fontSize: 10.px),))
      ],
    ),
  );
}
