import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/course_bloc.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/index.dart';
import 'package:ecommerceapp/config/constants.dart';
import 'package:ecommerceapp/pages/authentication/login/login_page.dart';
import 'package:ecommerceapp/pages/courses/chapters_page/chapters_page.dart';
import 'package:ecommerceapp/pages/courses/courses_page/courses_page.dart';
import 'package:ecommerceapp/pages/dashboard/components/bottom_app_bar.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

///
/// Created By (aurosmruti@smarttersstudio.com) on 7/13/2020 8:29 PM
///

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  //https://youtu.be/
  final code = 'omFCXZyIo88';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    CourseBloc().add(LoadMyCoursesEvent());
    _controller = YoutubePlayerController(
      initialVideoId: code,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.lerp(colorScheme.primary, Colors.black, 0.4)!,
                  Color.lerp(colorScheme.primary, Colors.black, 0.6)!
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
                      child: Row(
                        children: [
                          SizedBox(width: 16),
                          Flexible(
                              flex: 2,
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                          text: 'Hey, ', style: TextStyle()),
                                      TextSpan(
                                          text:
                                              '${SharedPreferenceHelper.user?.user?.firstName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800)),
                                      TextSpan(
                                          text:
                                              '.\nWhat you like to learn today?',
                                          style: TextStyle()),
                                    ]),
                              )),
                          Flexible(
                              flex: 3,
                              child:
                                  SvgPicture.asset('assets/icons/home_bg.svg'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Material(
//                    color: Color(0xFFF5F5F7),
                        shape: StadiumBorder(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Search here",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFA0A5BD),
                                ),
                              ),
                              SvgPicture.asset("assets/icons/search.svg"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Material(
                  borderRadius: BorderRadius.circular(22),
                  elevation: 6,
                  clipBehavior: Clip.antiAlias,
                  child: YoutubePlayer(
                    controller: _controller,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 16,
                  ),
                  Text("Courses", style: kTitleTextStyle),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(CoursesPage());
                    },
                    child: Text(
                      "See All",
                      style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                ],
              ),
              SizedBox(height: 10),
              BlocBuilder<CourseBloc, BaseState>(
                builder: (context, BaseState state) {
                  if (state is LoadingBaseState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ErrorBaseState) {
                    return Center(
                      child: Text(state.errorMessage.toString()),
                    );
                  }
                  if (state is EmptyBaseState) {
                    return Center(
                      child: Text("No Courses Available"),
                    );
                  }
                  if (state is CourseLoadedState) {
                    return SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 2,
//                      crossAxisSpacing: 16,
//                      mainAxisSpacing: 16,
//                      childAspectRatio: 1.5),
                        itemCount: CourseBloc().courses.length < 5
                            ? CourseBloc().courses.length
                            : 5,
                        separatorBuilder: (c, i) => SizedBox(
                          width: 16,
                        ),
                        itemBuilder: (context, index) {
                          return Material(
                            clipBehavior: Clip.antiAlias,
                            elevation: 4,
                            borderRadius: BorderRadius.circular(16),
                            shadowColor: Colors.grey[100],
                            child: InkWell(
                              onTap: () {
                                Get.to(ChaptersPage(
                                  course: CourseBloc().courses[index],
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      CourseBloc().courses[index].title,
                                      style: kTitleTextStyle,
                                    ),
                                    Text(
                                      '${CourseBloc().courses[index].chaptersCount} Chapters',
                                      style: TextStyle(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Center(
                    child: Text("Some Error Occurred "),
                  );
                },
              ),
            ],
          ),
          SafeArea(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.off(widget);
                    Get.to(LoginPage());
                    SharedPreferenceHelper.preferences.clear();
                  }),
            ],
          ))
        ],
      ),
      bottomNavigationBar: DashboardBottomAppbar(
        currentIndex: 0,
        onPageChange: (i) {},
      ),
    );
  }
}
