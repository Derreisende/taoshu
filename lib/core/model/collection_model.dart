// To parse this JSON data, do
//
//     final collectionModel = collectionModelFromJson(jsonString);

import 'dart:convert';

CollectionModel collectionModelFromJson(String str) => CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) => json.encode(data.toJson());

class CollectionModel {
  CollectionModel({
    this.artNo,
    this.freight,
    this.customPrice,
    this.userId,
    this.appearance,
    this.isbn,
    this.title,
    this.author,
    this.img,
    this.publisher,
  });

  String artNo;
  String freight;
  String customPrice;
  String userId;
  String appearance;
  String isbn;
  String title;
  String author;
  String img;
  String publisher;

  factory CollectionModel.fromJson(Map<String, dynamic> json) => CollectionModel(
    artNo: json["Art_No"],
    freight: json["freight"],
    customPrice: json["customPrice"],
    userId: json["user_id"],
    appearance: json["appearance"],
    isbn: json["ISBN"],
    title: json["title"],
    author: json["author"],
    img: json["img"],
    publisher: json["publisher"],
  );

  Map<String, dynamic> toJson() => {
    "Art_No": artNo,
    "freight": freight,
    "customPrice": customPrice,
    "user_id": userId,
    "appearance": appearance,
    "ISBN": isbn,
    "title": title,
    "author": author,
    "img": img,
    "publisher": publisher,
  };
}
