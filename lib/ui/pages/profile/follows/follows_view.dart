import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/utils/r.dart';
import 'package:booksea/core/extension/num_extension.dart';
import 'package:booksea/ui/pages/profile/follows/follows_controller.dart';

class FollowsView extends GetView<FollowsController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(()=>
        Scaffold(
          appBar: AppBar(
            title: Text(controller.title),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 16.px,
              onPressed: (){
                Get.back();
              },
            ),
            shape: Border(bottom: BorderSide(color: Colors.grey[200])),
          ),
          body: controller.loadingState == false ?
          Center(
            child: CircularProgressIndicator(),
          ) : controller.follows.length == 0 ?
          Center(
            child: Text("您还没关注任何人",style: TextStyle(fontSize: 18.px),),
          ) :
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: List.generate(controller.follows.length, (index) =>
                ListTile(
                  tileColor: Colors.white,
                  onTap: (){
                    Get.toNamed(AppPages.SELLER, arguments: controller.follows[index].userId);
                  },
                  dense: true,
                  leading: ClipOval(child: Image.network(R.sourceUrl+controller.follows[index].avatar,width: 26.px,height: 26.px,),),
                  title: Text(controller.follows[index].nickname,style: TextStyle(fontSize: 14.px),),
                  subtitle: Text(controller.follows[index].signature,maxLines: 1,style: TextStyle(color: Colors.black54),),
                  shape: Border(bottom: BorderSide(color: Colors.grey[200])),
                  trailing: controller.title == "我的关注" ?
                  TextButton(
                    onPressed: (){
                    controller.handleFollow(controller.follows[index].userId, index);
                  },
                    child: controller.follows[index].isFollow == false ? Text("  +  关注  ",style: TextStyle(fontSize: 14.px),) :
                      Text("≡已关注",style: TextStyle(fontSize: 14.px),),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                        return Colors.black87;
                      },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if(controller.follows[index].isFollow == true){
                          return Colors.grey;
                        }else{
                          return Colors.lightBlue;
                        }
                      }),
                    ),
                  ) : null,
                )
              )
            ),
          ),
        )
    );
  }
}