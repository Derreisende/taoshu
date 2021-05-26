import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/global_controller/auth_controller.dart';
import 'package:booksea/ui/pages/cart/cart_controller.dart';
import 'package:booksea/ui/pages/cart/cart_model.dart';
import 'package:booksea/ui/pages/home/widgets.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/home/home_controller.dart';
import 'package:booksea/core/router/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeContent extends StatelessWidget {
  HomeController homeCtl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    return  SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(
          waterDropColor: Colors.lightBlueAccent,
          complete: Text("刷新完成"),
          failed: Text("刷新失败"),
        ),
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
        controller: homeCtl.refreshController,
        onLoading: (){
          homeCtl.loadRecommends(skipNum: homeCtl.recommends.length);
        },
        onRefresh: (){
          homeCtl.onRefresh();
        },
        child:CustomScrollView(
            physics: BouncingScrollPhysics(),
            controller: homeCtl.scrollCtl,
            slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildSwiperCpn(),
                  buildBookList(),
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 10.px,top: 5.px,bottom: 10.px),
                      height: 50.px,
                      child: Text("好书推荐",style: TextStyle(fontSize: 18.px,fontWeight: FontWeight.normal),))
                ]
              )
          ),
              Obx(()=>SliverFixedExtentList(
              itemExtent: 130.px,
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Get.toNamed(AppPages.COMMODITY, arguments: homeCtl.recommends[index].artNo);
                  },
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
                            child: Image.network(homeCtl.recommends[index].img,fit:BoxFit.cover),
                          width: 70.px,
                          height: 100.px,
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
                              Text(homeCtl.recommends[index].title,style: TextStyle(fontSize: 14.px,fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5.px),
                              Text(homeCtl.recommends[index].author,style: TextStyle(fontSize: 12.px,color: Colors.grey),),
                              SizedBox(height: 5.px),
                              Text("￥"+homeCtl.recommends[index].customPrice,style: TextStyle(fontSize: 14.px,color: Colors.redAccent),),
                              Expanded(
                                child: Row(children: [
                                  ClipOval(child: Image.network(R.sourceUrl+homeCtl.recommends[index].avatar,width: 20.px,height: 20.px,fit: BoxFit.cover,),),
                                  Text("  "+homeCtl.recommends[index].nickname,style: TextStyle(fontSize: 10.px,fontWeight: FontWeight.w300),)
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
                                Map<String,dynamic> cartJson = homeCtl.recommends[index].toJson();
                                cartJson["isCheck"] = false;
                                cartJson['count'] = 1;
                                cartCtl.addCart(cartCtl.cartList, CartModel.fromJson(cartJson));
                              }
                        },
                            icon: Icon(MyIcons.cart_add,color: Colors.deepOrangeAccent,size: 18.px,)
                        )
                      ],
                    ),
                  ),
                );
              },
                  childCount: homeCtl.recommends.length),
              )
            ),
      ],
    )
    );
  }
}

//轮播图
Widget buildSwiperCpn(){
  List<String> img = ["assets/images/swipper/economic.jpg",
                      "assets/images/swipper/music.jpg",
                      "assets/images/swipper/literature.jpg"];
  List<String> listName = ["世界经济|让你更懂经济的好书","音乐人生|倾听世间的美好","文学世界|杰出文学作品"];
  return  Container(
    width: Get.width,
    height: Get.width / 2.25,
    padding: EdgeInsets.only(left: 8.px,right: 8.px,top: 10.px),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Swiper(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index){
        return  ClipRRect(
            borderRadius: BorderRadius.circular(8.px),
            child: GestureDetector(
                child: Image.asset(img[index],fit: BoxFit.fill,),
                onTap: (){
                  Get.toNamed(AppPages.LISTDETAIL,arguments: listName[index]);
                },
            )
        );
      },
      pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
            color: Colors.grey[300],
            activeColor: Colors.black87)
      ),
      autoplay: true,
    ),
  );
}

// 热门书单
Widget buildBookList(){
  HomeController homeCtl = Get.find<HomeController>();

  return Obx(()=>Container(
    padding: EdgeInsets.only(top: 10.px,bottom: 10.px),
    color: Colors.white,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("  热门书单",style: TextStyle(fontSize: 20.px,fontWeight: FontWeight.w800),),
            TextButton(
              onPressed: (){
                Get.toNamed(AppPages.BOOKLIST);
              },
              child: Text("更多",style: TextStyle(fontSize: 14.px,color: Colors.lightBlue),),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent)
              ),
            )
          ],
        ),
        SizedBox(height: 5.px),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.px,
          runSpacing: 8.px,
          children: List<Widget>.from(homeCtl.bls.map((listItem){
            return buildBookItem(listItem.cover, listItem.listName, ()=>{
              Get.toNamed(AppPages.LISTDETAIL,arguments: listItem.listName)
            });
          })),
        )
      ],
    ),
  )
  );

}


