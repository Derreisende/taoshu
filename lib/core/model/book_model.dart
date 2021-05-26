// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  BookModel({
    this.isbn,
    this.title,
    this.author,
    this.publisher,
    this.pubdate,
    this.edition,
    this.page,
    this.price,
    this.gist,
    this.img,
    this.format,
    this.binding,
    this.firstCategory,
    this.secondCategory,
  });

  String isbn;
  String title;
  String author;
  String publisher;
  String pubdate;
  String edition;
  String page;
  String price;
  String gist;
  String img;
  String format;
  String binding;
  String firstCategory;
  List<String> secondCategory;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    isbn: json["ISBN"],
    title: json["title"],
    author: json["author"],
    publisher: json["publisher"],
    pubdate: json["pubdate"],
    edition: json["edition"],
    page: json["page"],
    price: json["price"],
    gist: json["gist"],
    img: json["img"],
    format: json["format"],
    binding: json["binding"],
    firstCategory: json["firstCategory"],
    secondCategory: List<String>.from(json["secondCategory"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ISBN": isbn,
    "title": title,
    "author": author,
    "publisher": publisher,
    "pubdate": pubdate,
    "edition": edition,
    "page": page,
    "price": price,
    "gist": gist,
    "img": img,
    "format": format,
    "binding": binding,
    "firstCategory": firstCategory,
    "secondCategory": List<dynamic>.from(secondCategory.map((x) => x)),
  };
}
