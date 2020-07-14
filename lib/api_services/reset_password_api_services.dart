import 'package:ecommerceapp/api_services/base_api.dart';
import 'package:ecommerceapp/config/api_routes.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:flutter/material.dart';

///
/// Created By AURO (aurosmruti@smarttersstudio.com) on 7/14/2020 8:21 AM
///



Future<String> sendPasswordResetEmail({@required String email}) async {
  final result = await ApiCall.generalApiCall(
      ApiRoutes.forgetPassword, RequestMethod.create, body: {
    "email": email,
    "target": "email"
  });
  return result.data['message'];
}
