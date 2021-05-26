// To parse this JSON data, do
//
//     final sellerModel = sellerModelFromJson(jsonString);

import 'dart:convert';

SellerModel sellerModelFromJson(String str) => SellerModel.fromJson(json.decode(str));

String sellerModelToJson(SellerModel data) => json.encode(data.toJson());

class SellerModel {
  SellerModel({
    this.userId,
    this.nickname,
    this.sex,
    this.avatar,
    this.summary,
    this.follows,
    this.fans,
    this.collections,
    this.bookSelled,
    this.isFollow,
  });

  String userId;
  String nickname;
  String sex;
  String avatar;
  String summary;
  List<Fan> follows;
  List<Fan> fans;
  List<Collection> collections;
  List<BookSelled> bookSelled;
  bool isFollow;

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
    userId: json["user_id"],
    nickname: json["nickname"],
    sex: json["sex"],
    avatar: json["avatar"],
    summary: json["summary"],
    follows: List<Fan>.from(json["follows"].map((x) => Fan.fromJson(x))),
    fans: List<Fan>.from(json["fans"].map((x) => Fan.fromJson(x))),
    collections: List<Collection>.from(json["collections"].map((x) => Collection.fromJson(x))),
    bookSelled: List<BookSelled>.from(json["bookSelled"].map((x) => BookSelled.fromJson(x))),
    isFollow: json["isFollow"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "nickname": nickname,
    "sex": sex,
    "avatar": avatar,
    "summary": summary,
    "follows": List<dynamic>.from(follows.map((x) => x.toJson())),
    "fans": List<dynamic>.from(fans.map((x) => x.toJson())),
    "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
    "bookSelled": List<dynamic>.from(bookSelled.map((x) => x.toJson())),
    "isFollow": isFollow,
  };
}

class BookSelled {
  BookSelled({
    this.artNo,
    this.img,
    this.isbn,
    this.title,
    this.customPrice,
  });

  String artNo;
  String img;
  String isbn;
  String title;
  String customPrice;

  factory BookSelled.fromJson(Map<String, dynamic> json) => BookSelled(
    artNo: json["artNo"],
    img: json["img"],
    isbn: json["ISBN"],
    title: json["title"],
    customPrice: json["customPrice"],
  );

  Map<String, dynamic> toJson() => {
    "artNo": artNo,
    "img": img,
    "ISBN": isbn,
    "title": title,
    "customPrice": customPrice,
  };
}

class Collection {
  Collection({
    this.artNo,
  });

  String artNo;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    artNo: json["Art_No"],
  );

  Map<String, dynamic> toJson() => {
    "Art_No": artNo,
  };
}

class Fan {
  Fan({
    this.userId,
  });

  String userId;

  factory Fan.fromJson(Map<String, dynamic> json) => Fan(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
