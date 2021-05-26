import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.5,
          children: [
            Text("ss"),
            Text("ss"),
          ],
      ),
    );
  }
}