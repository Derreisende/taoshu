// To parse this JSON data, do
//
//     final followsModel = followsModelFromJson(jsonString);

import 'dart:convert';

FollowsModel followsModelFromJson(String str) => FollowsModel.fromJson(json.decode(str));

String followsModelToJson(FollowsModel data) => json.encode(data.toJson());

class FollowsModel {
  FollowsModel({
    this.userId,
    this.nickname,
    this.sex,
    this.avatar,
    this.signature,
    this.isFollow,
  });

  String userId;
  String nickname;
  String sex;
  String avatar;
  String signature;
  bool isFollow;

  factory FollowsModel.fromJson(Map<String, dynamic> json) => FollowsModel(
    userId: json["user_id"],
    nickname: json["nickname"],
    sex: json["sex"],
    avatar: json["avatar"],
    signature: json["signature"],
    isFollow: json["isFollow"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "nickname": nickname,
    "sex": sex,
    "avatar": avatar,
    "signature": signature,
    "isFollow": isFollow,
  };
}
