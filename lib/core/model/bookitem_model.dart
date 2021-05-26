// To parse this JSON data, do
//
//     final bookItemModel = bookItemModelFromJson(jsonString);

import 'dart:convert';

BookItemModel bookItemModelFromJson(String str) => BookItemModel.fromJson(json.decode(str));

String bookItemModelToJson(BookItemModel data) => json.encode(data.toJson());

//图书搜索列表的图书信息
class BookItemModel {
  BookItemModel({
    this.isbn,
    this.title,
    this.author,
    this.publisher,
    this.pubdate,
    this.img,
    this.binding,
    this.gist,
    this.minPrice,
    this.cover,
  });

  String isbn;
  String title;
  String author;
  String publisher;
  String pubdate;
  String img;
  String binding;
  String gist;
  String minPrice;
  String cover;

  factory BookItemModel.fromJson(Map<String, dynamic> json) => BookItemModel(
    isbn: json["ISBN"],
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
    pubdate: json["pubdate"],
    img: json["img"],
    binding: json["binding"],
    gist: json["gist"],
    minPrice: json["minPrice"],
    cover: json["cover"],
  );

  Map<String, dynamic> toJson() => {
    "ISBN": isbn,
    "title": title,
    "author": author,
    "publisher": publisher,
    "pubdate": pubdate,
    "img": img,
    "binding": binding,
    "gist": gist,
    "minPrice": minPrice,
    "cover": cover,
  };
}
