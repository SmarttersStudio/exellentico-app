import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/enums.dart';
import 'package:ecommerceapp/data_models/chapter_data.dart';
import 'package:ecommerceapp/data_models/course_data.dart';
import 'package:ecommerceapp/data_models/episode_data.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 9:58 PM
///


/// Api Call to get all courses
Future<CourseData> getAllCourses(int skip, int limit) async {
  String path = ApiRoutes.course +'?\$skip='+skip.toString()+'&\$limit='+limit.toString();
  print("Api Call");
  var result = await ApiCall.generalApiCall(path, RequestMethod.get);
  return CourseData.fromJson(result.data);
}

/// Api Call to get all chapters of a course of given id
Future<ChapterData> getAllChapters(String courseId, int skip, int limit) async {

  String path = ApiRoutes.chapter+'?courseId='+courseId+'&\$skip='+skip.toString()+'&\$limit='+limit.toString();
  var result = await ApiCall.generalApiCall(path, RequestMethod.get);
  return ChapterData.fromJson(result.data);
}

/// Api Call to get all episodes of a chapter of given id
Future<EpisodeData> getAllEpisodes(String episodeId, int skip, int limit) async {

  String path = ApiRoutes.episode+"?chapterId="+episodeId+'&\$skip='+skip.toString()+'&\$limit='+limit.toString();
  var result = await ApiCall.generalApiCall(path, RequestMethod.get);
  return EpisodeData.fromJson(result.data);
}














