// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.firstCategory,
    this.secondCategory,
  });

  String firstCategory;
  List<SecondCategory> secondCategory;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    firstCategory: json["firstCategory"],
    secondCategory: List<SecondCategory>.from(json["secondCategory"].map((x) => SecondCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "firstCategory": firstCategory,
    "secondCategory": List<dynamic>.from(secondCategory.map((x) => x.toJson())),
  };
}

class SecondCategory {
  SecondCategory({
    this.cateName,
    this.cateImg,
  });

  String cateName;
  String cateImg;

  factory SecondCategory.fromJson(Map<String, dynamic> json) => SecondCategory(
    cateName: json["cateName"],
    cateImg: json["cateImg"],
  );

  Map<String, dynamic> toJson() => {
    "cateName": cateName,
    "cateImg": cateImg,
  };
}
