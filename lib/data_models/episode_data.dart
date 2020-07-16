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
  List<String> attachments;
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
    id: json.containsKey('_id')
        ? json["_id"] != null ? json["_id"] : ''
        : null,
    attachments:  json.containsKey('attachments')
        ? json['attachments'] != null
        ? List<String>.from(json["attachments"].map((x) => x))
        : []
        : null,
    deleted: json.containsKey('deleted')
        ? json["deleted"] != null ? json["deleted"] : false
        : null,
    title: json.containsKey('title')
        ? json["title"] != null ? json["title"] : ''
        : null,
    videoUrl: json.containsKey('videoUrl')
        ? json["videoUrl"] != null ? json["videoUrl"] : ''
        : null,
    youtubeCode: json.containsKey('youtubeCode')
        ? json["youtubeCode"] != null ? json["youtubeCode"] : ''
        : null,
    chapterId: json.containsKey('chapterId')
        ? json["chapterId"] != null ? json["chapterId"] : ''
        : null,
    createdBy: json["createdBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "attachments": List<String>.from(attachments.map((x) => x)),
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
