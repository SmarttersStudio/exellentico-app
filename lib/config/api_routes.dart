///
/// Created By Guru (guru@smarttersstudio.com) on 12/06/20 2:33 PM
///
mixin ApiRoutes {
  static const baseUrl = 'http://192.168.137.1:3030';
  static const upload = 'upload';
  static const String geoCoderApi =
    'https://maps.googleapis.com/maps/api/geocode/json';


  static const String signInWithEmail = "authentication";
  static const String signInWithSocialMedia = "social-login";
  static const String signUp = "user";
  static const String checkUserName = "check-user-name";
  static const String forgetPassword = "forget-password";
  static const String phoneVerify = "phone-verification";
  static const String verifyOTP = "verify-phone-otp";
  static const String course = "course";
  static const String chapter = "chapter";
  static const String episode = "episode";
}
