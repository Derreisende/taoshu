// To parse this JSON data, do
//
//     final publishModel = publishModelFromJson(jsonString);

import 'dart:convert';

PublishModel publishModelFromJson(String str) => PublishModel.fromJson(json.decode(str));

String publishModelToJson(PublishModel data) => json.encode(data.toJson());

class PublishModel {
  PublishModel({
    this.artNo,
    this.img,
    this.customPrice,
    this.isbn,
    this.title,
    this.author,
    this.publisher,
    this.price,
    this.firstCategory,
    this.secondCategory,
    this.freight,
    this.appearance,
    this.deliveryLocation,
  });

  String artNo;
  String img;
  String customPrice;
  String isbn;
  String title;
  String author;
  String publisher;
  String price;
  String firstCategory;
  List<String> secondCategory;
  String freight;
  String appearance;
  String deliveryLocation;

  factory PublishModel.fromJson(Map<String, dynamic> json) => PublishModel(
    artNo: json["artNo"],
    img: json["img"],
    customPrice: json["customPrice"],
    isbn: json["ISBN"],
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
    price: json["price"],
    firstCategory: json["firstCategory"],
    secondCategory: List<String>.from(json["secondCategory"].map((x) => x)),
    freight: json["freight"],
    appearance: json["appearance"],
    deliveryLocation: json["deliveryLocation"],
  );

  Map<String, dynamic> toJson() => {
    "artNo": artNo,
    "img": img,
    "customPrice": customPrice,
    "ISBN": isbn,
    "title": title,
    "author": author,
    "publisher": publisher,
    "price": price,
    "firstCategory": firstCategory,
    "secondCategory": List<dynamic>.from(secondCategory.map((x) => x)),
    "freight": freight,
    "appearance": appearance,
    "deliveryLocation": deliveryLocation,
  };
}
