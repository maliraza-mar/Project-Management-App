import 'package:flutter/material.dart';
import 'package:my_app/user_side_pages/dashboard.dart';
import 'package:my_app/user_side_pages/insights.dart';
import 'package:my_app/user_side_pages/projects_navbar_pages/projects_details.dart';
import 'package:my_app/user_side_pages/projects_navbarpages.dart';

class UserSidePages extends StatefulWidget {
  const UserSidePages({super.key});

  @override
  State<UserSidePages> createState() => _UserSidePagesState();
}

class _UserSidePagesState extends State<UserSidePages> {
  int currentTab = 0;

  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
            children: [
              //Screen 1
              Dashboard(),

              //Screen 2
              ProjectsNavBarPages(),

              //Screen3
              Insights(),
            ]
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            //height: 50,
            child: TabBar(
              onTap: (index) {
                setState(() {
                  currentTab = index;
                });
                if (index == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsNavBarPages()));
                }
              },
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                indicatorColor: const Color(0xff07aeaf),
                tabs: [

                  //1st Tab of Home
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.home_outlined,
                          color: currentTab == 0 ? Colors.black : Colors.grey.shade500,),
                        Text('Home',
                          style: TextStyle(
                              color: currentTab == 0 ? Colors.black : Colors.grey.shade500,),)
                      ],
                    ),
                  ),

                  //2nd Tab of Projects
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.list_alt,
                          color: currentTab == 1 ? Colors.black : Colors.grey.shade500,),
                        Text('Projects',
                          style: TextStyle(
                              color: currentTab == 1 ? Colors.black : Colors.grey.shade500,),)
                      ],
                    ),
                  ),

                  //3rd Tab of Insights
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.bar_chart,
                          color: currentTab == 2 ? Colors.black : Colors.grey.shade500,),
                        Text('Insights',
                          style: TextStyle(
                              color: currentTab == 2 ? Colors.black : Colors.grey.shade500,),)
                      ],
                    ),
                  )
            ]),
          ),
        ),


      )
    );
  }
}

