import 'package:ecommerceapp/bloc_models/base_state.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/course_bloc.dart';
import 'package:ecommerceapp/bloc_models/course_bloc/index.dart';
import 'package:ecommerceapp/config/constants.dart';
import 'package:ecommerceapp/pages/courses/courses_page/courses_page.dart';
import 'package:ecommerceapp/utils/shared_preference_helper.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

///
/// Created By (aurosmruti@smarttersstudio.com) on 7/13/2020 8:29 PM
///

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin{
  
  FancyDrawerController _controller ;
  @override
  void initState() {
    _controller = FancyDrawerController(
      vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {}); // Must call setState
      });
    super.initState();
    CourseBloc().add(LoadMyCoursesEvent());
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FancyDrawerWrapper(
      hideOnContentTap: true,
      backgroundColor: Colors.white,
      controller: _controller,
      drawerItems: <Widget>[],
    child: Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 50, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
              if(_controller.state == DrawerState.closed){
                _controller.open();
              }else
                _controller.close();
                  },
                  child: SvgPicture.asset("assets/icons/menu.svg")),
                CircleAvatar(
                  backgroundImage: NetworkImage(SharedPreferenceHelper.user.user.avatar),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Hey ${SharedPreferenceHelper.user.user.firstName},", style: kHeadingextStyle),
            Text("Find a course you want to learn", style: kSubheadingextStyle),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/search.svg"),
                  SizedBox(width: 16),
                  Text(
                    "Search for anything",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFA0A5BD),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Popular Videos", style: kTitleTextStyle),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 120,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index)=>Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(''),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ABCD',
                      style: kTitleTextStyle,
                    ),
                    Text(
                      '10 Courses',
                      style: TextStyle(
                        color: kTextColor.withOpacity(.5),
                      ),
                    )
                  ],
                ),
              ),scrollDirection: Axis.horizontal,),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Courses", style: kTitleTextStyle),
                GestureDetector(
                  onTap: (){
                    Get.to(CoursesPage());
                  },
                  child: Text(
                    "See All",
                    style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<CourseBloc, BaseState>(
                bloc: CourseBloc(),
                builder: (context, BaseState state){
                  if(state is LoadingBaseState){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(state is ErrorBaseState){
                    return Center(child: Text(state.errorMessage.toString()),);
                  }
                  if(state is EmptyBaseState){
                    return Center(child: Text("No Courses Available"),);
                  }
                  if(state is CourseLoadedState){
                    return StaggeredGridView.countBuilder(
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 2,
                      itemCount: 10,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          height: index.isEven ? 200 : 240,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(''),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                CourseBloc().courses[index].title,
                                style: kTitleTextStyle,
                              ),
                              Text(
                                '${CourseBloc().courses[index].chaptersCount} Chapters',
                                style: TextStyle(
                                  color: kTextColor.withOpacity(.5),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    );
                  }
                  return Center(child: Text("Some Error Occurred "),);
                },
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

