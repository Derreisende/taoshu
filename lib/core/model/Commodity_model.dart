// To parse this JSON data, do
//
//     final commodityModel = commodityModelFromJson(jsonString);

import 'dart:convert';

CommodityModel commodityModelFromJson(String str) => CommodityModel.fromJson(json.decode(str));

String commodityModelToJson(CommodityModel data) => json.encode(data.toJson());

class CommodityModel {
  CommodityModel({
    this.isbn,
    this.artNo,
    this.userId,
    this.nickname,
    this.avatar,
    this.sex,
    this.customPrice,
    this.appearance,
    this.freight,
    this.deliveryLocation,
    this.title,
    this.author,
    this.publisher,
    this.pubdate,
    this.img,
    this.edition,
    this.price,
    this.gist,
    this.format,
    this.binding,
    this.firstCategory,
    this.secondCategory,
    this.evaluation,
  });

  String isbn;
  String artNo;
  String userId;
  String nickname;
  String avatar;
  String sex;
  String customPrice;
  String appearance;
  String freight;
  String deliveryLocation;
  String title;
  String author;
  String publisher;
  String pubdate;
  String img;
  String edition;
  String price;
  String gist;
  String format;
  String binding;
  String firstCategory;
  List<String> secondCategory;
  List<Evaluation> evaluation;

  factory CommodityModel.fromJson(Map<String, dynamic> json) => CommodityModel(
    isbn: json["ISBN"],
    artNo: json["Art_No"],
    userId: json["user_id"],
    nickname: json["nickname"],
    avatar: json["avatar"],
    sex: json["sex"],
    customPrice: json["customPrice"],
    appearance: json["appearance"],
    freight: json["freight"],
    deliveryLocation: json["deliveryLocation"],
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
    pubdate: json["pubdate"],
    img: json["img"],
    edition: json["edition"],
    price: json["price"],
    gist: json["gist"],
    format: json["format"],
    binding: json["binding"],
    firstCategory: json["firstCategory"],
    secondCategory: List<String>.from(json["secondCategory"].map((x) => x)),
    evaluation: List<Evaluation>.from(json["evaluation"].map((x) => Evaluation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ISBN": isbn,
    "Art_No": artNo,
    "user_id": userId,
    "nickname": nickname,
    "avatar": avatar,
    "sex": sex,
    "customPrice": customPrice,
    "appearance": appearance,
    "freight": freight,
    "deliveryLocation": deliveryLocation,
    "title": title,
    "author": author,
    "publisher": publisher,
    "pubdate": pubdate,
    "img": img,
    "edition": edition,
    "price": price,
    "gist": gist,
    "format": format,
    "binding": binding,
    "firstCategory": firstCategory,
    "secondCategory": List<dynamic>.from(secondCategory.map((x) => x)),
    "evaluation": List<dynamic>.from(evaluation.map((x) => x.toJson())),
  };
}

class Evaluation {
  Evaluation({
    this.userId,
    this.nickname,
    this.avatar,
    this.sex,
    this.comments,
    this.commentImg,
  });

  String userId;
  String nickname;
  String avatar;
  String sex;
  dynamic comments;
  dynamic commentImg;

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
    userId: json["user_id"],
    nickname: json["nickname"],
    avatar: json["avatar"],
    sex: json["sex"],
    comments: json["comments"],
    commentImg: json["commentImg"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "nickname": nickname,
    "avatar": avatar,
    "sex": sex,
    "comments": comments,
    "commentImg": commentImg,
  };
}
