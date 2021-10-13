import 'dart:convert';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 2:58 PM
///

CourseData courseDataFromJson(String str) =>
    CourseData.fromJson(json.decode(str));

String courseDataToJson(CourseData data) => json.encode(data.toJson());

class CourseData {
  CourseData({
    required this.total,
    required this.limit,
    required this.skip,
    required this.data,
  });

  int total;
  int limit;
  int skip;
  List<CourseDatum> data;

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        total: json["total"],
        limit: json["limit"],
        skip: json["skip"],
        data: List<CourseDatum>.from(
            json["data"].map((x) => CourseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "skip": skip,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CourseDatum {
  CourseDatum({
    required this.id,
    required this.points,
    required this.attachments,
    required this.chaptersCount,
    required this.episodesCount,
    required this.onTrending,
    required this.deleted,
    required this.title,
    required this.description,
    required this.avatar,
    required this.promoVideo,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  List<String> points;
  List<String> attachments;
  int chaptersCount;
  int episodesCount;
  bool onTrending;
  bool deleted;
  String title;
  String description;
  String avatar;
  String promoVideo;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory CourseDatum.fromJson(Map<String, dynamic> json) => CourseDatum(
        id: json.containsKey('_id')
            ? json["_id"] != null
                ? json["_id"]
                : ''
            : null,
        points: json.containsKey('points')
            ? json['points'] != null
                ? List<String>.from(json["points"].map((x) => x))
                : []
            : [],
        attachments: json.containsKey('attachments')
            ? json['attachments'] != null
                ? List<String>.from(json["attachments"].map((x) => x))
                : []
            : [],
        chaptersCount: json.containsKey('chaptersCount')
            ? json["chaptersCount"] != null
                ? json["chaptersCount"]
                : 0
            : null,
        episodesCount: json.containsKey('episodesCount')
            ? json["episodesCount"] != null
                ? json["episodesCount"]
                : 0
            : null,
        onTrending: json.containsKey('onTrending')
            ? json["onTrending"] != null
                ? json["onTrending"]
                : false
            : null,
        deleted: json.containsKey('deleted')
            ? json["deleted"] != null
                ? json["deleted"]
                : false
            : null,
        title: json.containsKey('title')
            ? json["title"] != null
                ? json["title"]
                : ''
            : null,
        description: json.containsKey('description')
            ? json["description"] != null
                ? json["description"]
                : ''
            : null,
        avatar: json.containsKey('avatar')
            ? json["avatar"] != null
                ? json["avatar"]
                : ''
            : null,
        promoVideo: json.containsKey('promoVideo')
            ? json["promoVideo"] != null
                ? json["promoVideo"]
                : ''
            : null,
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "points": List<String>.from(points.map((x) => x)),
        "attachments": List<String>.from(attachments.map((x) => x)),
        "chaptersCount": chaptersCount,
        "episodesCount": episodesCount,
        "onTrending": onTrending,
        "deleted": deleted,
        "title": title,
        "description": description,
        "avatar": avatar,
        "promoVideo": promoVideo,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
