// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) => SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  String? id;
  String? title;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SliderModel({
    this.id,
    this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["_id"],
    title: json["title"],
    image: json["image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "image": image,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
