import 'dart:convert';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 3:00 PM
///



ChapterData chapterDataFromJson(String str) => ChapterData.fromJson(json.decode(str));

String chapterDataToJson(ChapterData data) => json.encode(data.toJson());

class ChapterData {
  ChapterData({
    required this.total,
    required    this.limit,
    required   this.skip,
    required   this.data,
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
    "data":  List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ChapterDatum {
  ChapterDatum({
    required  this.id,
    required   this.deleted,
    required  this.name,
    required     this.description,
    required  this.courseId,
    required     this.createdBy,
    required  this.createdAt,
    required  this.updatedAt,
    required  this.v,
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
    id:  json.containsKey('_id')
        ? json["_id"] != null ? json["_id"] : ''
        : null,
    deleted: json.containsKey('deleted')
        ? json["deleted"] != null ? json["deleted"] : false
        : null,
    name: json.containsKey('name')
        ? json["name"] != null ? json["name"] : ''
        : null,
    description: json.containsKey('description')
        ? json["description"] != null ? json["description"] : ''
        : null,
    courseId: json.containsKey('courseId')
        ? json["courseId"] != null ? json["courseId"] : ''
        : null,
    createdBy: json["createdBy"]!=null ? json["createdBy"] : '',
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
