// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.receivingAddress,
    this.userId,
    this.nickname,
    this.phoneNumber,
    this.email,
    this.password,
    this.sex,
    this.avatar,
    this.address,
    this.signature,
    this.summary,
    this.follows,
    this.fans,
    this.collections,
  });

  List<ReceivingAddress> receivingAddress;
  String userId;
  String nickname;
  String phoneNumber;
  String email;
  String password;
  String sex;
  String avatar;
  String address;
  String signature;
  String summary;
  List<Fan> follows;
  List<Fan> fans;
  List<Collection> collections;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    receivingAddress: List<ReceivingAddress>.from(json["receivingAddress"].map((x) => ReceivingAddress.fromJson(x))),
    userId: json["user_id"],
    nickname: json["nickname"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    password: json["password"],
    sex: json["sex"],
    avatar: json["avatar"],
    address: json["address"],
    signature: json["signature"],
    summary: json["summary"],
    follows: List<Fan>.from(json["follows"].map((x) => Fan.fromJson(x))),
    fans: List<Fan>.from(json["fans"].map((x) => Fan.fromJson(x))),
    collections: List<Collection>.from(json["collections"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "receivingAddress": List<dynamic>.from(receivingAddress.map((x) => x.toJson())),
    "user_id": userId,
    "nickname": nickname,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "sex": sex,
    "avatar": avatar,
    "address": address,
    "signature": signature,
    "summary": summary,
    "follows": List<dynamic>.from(follows.map((x) => x.toJson())),
    "fans": List<dynamic>.from(fans.map((x) => x.toJson())),
    "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
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

class ReceivingAddress {
  ReceivingAddress({
    this.addNo,
    this.consignee,
    this.phoneNumber,
    this.area,
    this.detailAddress,
    this.postalCode,
  });

  String addNo;
  String consignee;
  String phoneNumber;
  String area;
  String detailAddress;
  String postalCode;

  factory ReceivingAddress.fromJson(Map<String, dynamic> json) => ReceivingAddress(
    addNo: json["add_no"],
    consignee: json["consignee"],
    phoneNumber: json["phoneNumber"],
    area: json["area"],
    detailAddress: json["detailAddress"],
    postalCode: json["postalCode"],
  );

  Map<String, dynamic> toJson() => {
    "add_no": addNo,
    "consignee": consignee,
    "phoneNumber": phoneNumber,
    "area": area,
    "detailAddress": detailAddress,
    "postalCode": postalCode,
  };
}
