import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/enums.dart';
import 'package:ecommerceapp/data_models/chapter_data.dart';
import 'package:ecommerceapp/data_models/course_data.dart';
import 'package:ecommerceapp/data_models/episode_data.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 9:58 PM
///



Future<CourseData> getAllCourses() async {

  String path = ApiRoutes.course;
  print("Api Call");
  var result = await ApiCall.generalApiCall(path, RequestMethod.get);
  print(result.data.toString());
  return CourseData.fromJson(result.data);
}

Future<ChapterData> getAllChapters(String courseId) async {

  String path = ApiRoutes.chapter+'?courseId='+courseId;
  var result = await ApiCall.generalApiCall(path, RequestMethod.get);
  print(result.data.toString());
  return ChapterData.fromJson(result.data);
}

Future<EpisodeData> getAllEpisodes(String episodeId) async {

  String path = ApiRoutes.episode+"?chapterId="+episodeId;
  var result = await ApiCall.generalApiCall(path, RequestMethod.get);
  print(result.data.toString());
  return EpisodeData.fromJson(result.data);
}














