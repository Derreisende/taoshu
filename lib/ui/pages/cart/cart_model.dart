// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.userId,
    this.count,
    this.isCheck,
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
  int count;
  bool isCheck;
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

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    userId: json["userId"],
    count: json["count"],
    isCheck: json["isCheck"],
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
    "count": count,
    "isCheck": isCheck,
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
