import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/enums.dart';
import 'package:ecommerceapp/data_models/check_user_name_data.dart';
import 'package:ecommerceapp/data_models/user.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 7/1/2020 11:38 AM
///

/// Api Call to sign in using email id
Future<UserResponse> signInWithEmail(
    {@required String email, @required String password}) async {
  var body = {'strategy': 'local', 'email': email, 'password': password};
  String path = ApiRoutes.signInWithEmail;
  var resultMap = await ApiCall.generalApiCall(path, RequestMethod.create,
      body: body, isAuthNeeded: false);
  print(resultMap);
  SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
  return UserResponse.fromJson(resultMap.data['me']);
}

/// Api Call to sign up using email id
Future<UserResponse> signUpWithEmail({
  @required String email,
  @required String password,
  @required String firstName,
  @required String lastName,
  int role = 1,
}) async {
  var body = {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'role': role
  };
  String path = ApiRoutes.signUp;

  final resultMap = await ApiCall.generalApiCall(path, RequestMethod.create,
      body: body, isAuthNeeded: false);
  print("Access Token : " + resultMap.data['accessToken'].toString());
  SharedPreferenceHelper.storeAccessToken(
      resultMap.data['accessToken'].toString());

  return UserResponse.fromJson(resultMap.data['me']);
}

/// Api call to sign up using social media
Future<UserResponse> signInWithSocialMedia(
    {@required String socialToken,
    @required int socialAuthType,
    int role = 1,
    String tokenSecret = ""}) async {
  print("Social Api Call");
  var body = {'accessToken': socialToken, 'type': socialAuthType, 'role': role};

  String path = ApiRoutes.signInWithSocialMedia;

  final resultMap = await ApiCall.generalApiCall(path, RequestMethod.create,
      body: body, isAuthNeeded: false);
  SharedPreferenceHelper.storeAccessToken(
      resultMap.data['accessToken'].toString());

  return UserResponse.fromJson(resultMap.data['me']);
}

Future<CheckUserNameData> verifyUserName({@required String userName}) async {
  print(userName);
  final result = await ApiCall.generalApiCall(
      '${ApiRoutes.checkUserName}?userName=$userName', RequestMethod.get);
  return CheckUserNameData.fromJson(result.data);
}
