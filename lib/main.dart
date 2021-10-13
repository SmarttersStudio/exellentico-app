import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/blog_delagate.dart';
import 'package:ecommerceapp/bloc_models/chapter_bloc/chapter_bloc.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/index.dart';
import 'package:ecommerceapp/bloc_models/episode_bloc/episode_bloc.dart';
import 'package:ecommerceapp/config/index.dart';
import 'package:ecommerceapp/pages/dashboard/dashboard_page.dart';
import 'package:ecommerceapp/pages/splash/splash_screen.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  SharedPreferenceHelper.preferences = await SharedPreferences.getInstance();

  /// Setup for notification services
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => CourseBloc()),
    BlocProvider(create: (context) => ChapterBloc()),
    BlocProvider(create: (context) => EpisodeBloc()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    CourseBloc().close();
    ChapterBloc().close();
    EpisodeBloc().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exellentico Learning',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: MyThemes.appThemeData[ColorThemes.red]![ThemeMode.light],
      darkTheme: MyThemes.appThemeData[ColorThemes.red]![ThemeMode.dark],
      home: SplashPage(),
    );
  }
}
