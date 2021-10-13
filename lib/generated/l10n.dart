// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter Demo Home Page`
  String get flutterDemoHomePage {
    return Intl.message(
      'Flutter Demo Home Page',
      name: 'flutterDemoHomePage',
      desc: '',
      args: [],
    );
  }

  /// `LogIn Page`
  String get loginAppBar {
    return Intl.message(
      'LogIn Page',
      name: 'loginAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get loginButton {
    return Intl.message(
      'Submit',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Email Id`
  String get email {
    return Intl.message(
      'Email Id',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `OTP Page`
  String get otpPage {
    return Intl.message(
      'OTP Page',
      name: 'otpPage',
      desc: '',
      args: [],
    );
  }

  /// `Exellentico`
  String get exellentico {
    return Intl.message(
      'Exellentico',
      name: 'exellentico',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Crop Your Image`
  String get cropYourImage {
    return Intl.message(
      'Crop Your Image',
      name: 'cropYourImage',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get oops {
    return Intl.message(
      'Oops!',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Please allow permission to upload image.`
  String get pleaseAllowPermissionToUploadImage {
    return Intl.message(
      'Please allow permission to upload image.',
      name: 'pleaseAllowPermissionToUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `*required`
  String get required {
    return Intl.message(
      '*required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidPhoneNumber {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get buttonContinue {
    return Intl.message(
      'Continue',
      name: 'buttonContinue',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive any code?`
  String get didNtYouReceivedAnyCode {
    return Intl.message(
      'Didn’t receive any code?',
      name: 'didNtYouReceivedAnyCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter your OTP code here`
  String get enterYourOtpCodeHere {
    return Intl.message(
      'Enter your OTP code here',
      name: 'enterYourOtpCodeHere',
      desc: '',
      args: [],
    );
  }

  /// `Phone Verification`
  String get phoneVerification {
    return Intl.message(
      'Phone Verification',
      name: 'phoneVerification',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Verify your Phone number`
  String get verifyYourPhoneNumber {
    return Intl.message(
      'Verify your Phone number',
      name: 'verifyYourPhoneNumber',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
