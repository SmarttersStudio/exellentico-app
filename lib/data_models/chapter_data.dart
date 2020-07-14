import 'dart:convert';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 3:00 PM
///



ChapterData chapterDataFromJson(String str) => ChapterData.fromJson(json.decode(str));

String chapterDataToJson(ChapterData data) => json.encode(data.toJson());

class ChapterData {
  ChapterData({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int total;
  int limit;
  int skip;
  List<ChapterDatum> data;

  factory ChapterData.fromJson(Map<String, dynamic> json) => ChapterData(
    total: json["total"],
    limit: json["limit"],
    skip: json["skip"],
    data: List<ChapterDatum>.from(json["data"].map((x) => ChapterDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "skip": skip,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ChapterDatum {
  ChapterDatum({
    this.id,
    this.deleted,
    this.name,
    this.description,
    this.courseId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  bool deleted;
  String name;
  String description;
  String courseId;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory ChapterDatum.fromJson(Map<String, dynamic> json) => ChapterDatum(
    id: json["_id"],
    deleted: json["deleted"],
    name: json["name"],
    description: json["description"],
    courseId: json["courseId"],
    createdBy: json["createdBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "deleted": deleted,
    "name": name,
    "description": description,
    "courseId": courseId,
    "createdBy": createdBy,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
