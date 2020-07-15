import 'dart:convert';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 3:01 PM
///


EpisodeData episodeDataFromJson(String str) => EpisodeData.fromJson(json.decode(str));

String episodeDataToJson(EpisodeData data) => json.encode(data.toJson());

class EpisodeData {
  EpisodeData({
    this.total,
    this.limit,
    this.skip,
    this.data,
  });

  int total;
  int limit;
  int skip;
  List<EpisodeDatum> data;

  factory EpisodeData.fromJson(Map<String, dynamic> json) => EpisodeData(
    total: json["total"],
    limit: json["limit"],
    skip: json["skip"],
    data: List<EpisodeDatum>.from(json["data"].map((x) => EpisodeDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "skip": skip,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class EpisodeDatum {
  EpisodeDatum({
    this.id,
    this.attachments,
    this.deleted,
    this.title,
    this.videoUrl,
    this.youtubeCode,
    this.chapterId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  List<dynamic> attachments;
  bool deleted;
  String title;
  String videoUrl;
  String youtubeCode;
  String chapterId;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory EpisodeDatum.fromJson(Map<String, dynamic> json) => EpisodeDatum(
    id: json["_id"],
    attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
    deleted: json["deleted"],
    title: json["title"],
    videoUrl: json["videoUrl"],
    youtubeCode: json["youtubeCode"],
    chapterId: json["chapterId"],
    createdBy: json["createdBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "attachments": List<dynamic>.from(attachments.map((x) => x)),
    "deleted": deleted,
    "title": title,
    "videoUrl": videoUrl,
    "youtubeCode": youtubeCode,
    "chapterId": chapterId,
    "createdBy": createdBy,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
