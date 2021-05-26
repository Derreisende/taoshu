import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/profile/profile_content.dart';
import 'package:booksea/ui/pages/profile/profile_controller.dart';

class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   ProfileController profileCtl = Get.find<ProfileController>();

    return Scaffold(
        body: Stack(
          children: <Widget>[
            ///监听滚动
            NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  ///滑动通知
                  profileCtl.scrollViewDidScrolled(notification.metrics.pixels);
                }
                ///通知不再上传
                return true;
              },
              child: ProfileContent()
            ),
            profileCtl.appBar,
          ],
        )
    );
  }
}