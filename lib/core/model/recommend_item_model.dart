// To parse this JSON data, do
//
//     final recommendItemModel = recommendItemModelFromJson(jsonString);

import 'dart:convert';

RecommendItemModel recommendItemModelFromJson(String str) => RecommendItemModel.fromJson(json.decode(str));

String recommendItemModelToJson(RecommendItemModel data) => json.encode(data.toJson());

class RecommendItemModel {
  RecommendItemModel({
    this.userId,
    this.isbn,
    this.artNo,
    this.nickname,
    this.avatar,
    this.sex,
    this.customPrice,
    this.title,
    this.author,
    this.publisher,
    this.img,
    this.appearance,
    this.freight,
  });

  String userId;
  String isbn;
  String artNo;
  String nickname;
  String avatar;
  String sex;
  String customPrice;
  String title;
  String author;
  String publisher;
  String img;
  String appearance;
  String freight;

  factory RecommendItemModel.fromJson(Map<String, dynamic> json) => RecommendItemModel(
    userId: json["user_id"],
    isbn: json["ISBN"],
    artNo: json["Art_No"],
    nickname: json["nickname"],
    avatar: json["avatar"],
    sex: json["sex"],
    customPrice: json["customPrice"],
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
    img: json["img"],
    appearance: json["appearance"],
    freight: json["freight"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "ISBN": isbn,
    "Art_No": artNo,
    "nickname": nickname,
    "avatar": avatar,
    "sex": sex,
    "customPrice": customPrice,
    "title": title,
    "author": author,
    "publisher": publisher,
    "img": img,
    "appearance": appearance,
    "freight": freight,
  };
}
