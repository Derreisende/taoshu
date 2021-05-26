import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:booksea/core/router/app_pages.dart';
import 'package:booksea/ui/shared/myicon.dart';
import 'package:booksea/ui/utils/app_config.dart';
///app barb
class AppBarWidget extends StatefulWidget {
  Function updateAppBarOpacity;

  @override
  State<StatefulWidget> createState() => AppBarState();
}

class AppBarState extends State<AppBarWidget> {
  double opacity = 0;

  @override
  void initState() {
    if (widget != null) {
      widget.updateAppBarOpacity = (double op) {
        setState(() {
          opacity = op;
        });
      };
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double appBarHeight = MediaQuery.of(context).padding.top;
    appBarHeight += AppConfig.toolbarHeight;

    return Opacity(
      opacity: opacity,
      child: Container(
        height: appBarHeight,
        child: AppBar(
          title: Text('个人中心'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(MyIcons.setting),
                onPressed: (){
                    Get.toNamed(AppPages.SETTING);
                }),
            IconButton(
                icon: Icon(MyIcons.news_outlined),
                onPressed: (){

                }
            )
          ],
        ),
      ),
    );
  }
}