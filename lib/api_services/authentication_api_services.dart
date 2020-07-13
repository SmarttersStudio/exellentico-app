
import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/enums.dart';
import 'package:ecommerceapp/data_models/user.dart';
import 'package:flutter/material.dart';

///
///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 7/1/2020 11:38 AM
///


/// Api Call to sign in using email id
Future<UserDatum> signInWithEmail({
    @required String email,
    @required String password
}) async {

    var body = {
        'strategy' : 'local',
        'email' : email,
        'password' : password
    };
    String path = ApiRoutes.signInWithEmail;

    var resultMap = await ApiCall.generalApiCall(path, RequestMethod.create, body: body, isAuthNeeded: false);

    print("Access Token : "+ resultMap.data['accessToken'].toString());
    return UserDatum.fromJson(resultMap.data['user']);
}

/// Api Call to sign up using email id
Future<UserDatum> signUpWithEmail({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
    @required String phone,
    int role = 5,
    List<double> coordinates = const [0,0],
    bool phoneVerified = false,
    bool emailVerified = false
}) async {

    var body = {
      'firstName' : firstName,
        'lastName' : lastName,
        'email' : email,
        'password' : password,
        'phone' : phone,
        'coordinates' : coordinates,
        'role' : role,
        'phoneVerified' : phoneVerified,
        'emailVerified' : emailVerified
    };
    String path = ApiRoutes.signUp;

    final resultMap = await ApiCall.generalApiCall(path, RequestMethod.create, body: body, isAuthNeeded: false);

    return UserDatum.fromJson(resultMap.data);

}

/// Api call to sign up using social media
Future<UserResponse> signInWithSocialMedia({
    @required String socialToken,
    @required int socialAuthType,
    bool isTwitter = false,
    String tokenSecret = ""
}) async {
    print("Social Api Call");
    var body = isTwitter ? {
        'accessToken': socialToken,
        'type': socialAuthType,
        'accessTokenSecret': tokenSecret
    } : {
        'accessToken': socialToken,
        'type': socialAuthType
    };
    String path = ApiRoutes.signInWithSocialMedia;

    final resultMap = await ApiCall.generalApiCall(
        path, RequestMethod.create, body: body, isAuthNeeded: false);

    return UserResponse.fromJson(resultMap.data['me']);
}