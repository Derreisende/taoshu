import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:booksea/ui/pages/splash/splash_controller.dart';
import 'package:booksea/ui/utils/r.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(R.assetsImagesSplash),
              fit: BoxFit.cover
          )
        ),
      )
    );
   }
}

