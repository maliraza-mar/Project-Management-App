import 'package:flutter/material.dart';
import 'package:my_app/user_side_pages/projects_navbar_pages/all_projects.dart';
import 'package:my_app/user_side_pages/projects_navbar_pages/completed_projects.dart';
import 'package:my_app/user_side_pages/projects_navbar_pages/pending_projects.dart';
import 'package:my_app/user_side_pages/projects_navbar_pages/projects_details.dart';
import 'package:my_app/user_side_pages/projects_navbar_pages/revisions_projects.dart';

class ProjectsNavBarPages extends StatefulWidget {
  const ProjectsNavBarPages({super.key});

  @override
  State<ProjectsNavBarPages> createState() => _ProjectsNavBarPagesState();
}

class _ProjectsNavBarPagesState extends State<ProjectsNavBarPages> {

  int currentTab = 0;
  List<Widget> screens = [
    const AllProjects(),
    const PendingProjects(),
    const RevisionProjects(),
    const CompletedProjects(),
    const ProjectsDetails(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const AllProjects();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(                       //for wraping with new Widget Do this => (alt + enter)
        appBar: AppBar(
            backgroundColor: Colors.grey.shade100,

            automaticallyImplyLeading: false,
            title: const Text('Projects', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 23,
                  backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_640.png'),
                ),
              ),
            ],
            bottom: TabBar(
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                labelPadding: const EdgeInsets.only(right: 5),
                labelColor: const Color(0xff07aeaf),
                indicatorColor: const Color(0xff07aeaf),
                unselectedLabelColor: Colors.grey.shade400,
                tabs: const [
                  Tab(
                    iconMargin: EdgeInsets.only(bottom: 3),
                    icon: Icon(Icons.home_outlined),
                    text: 'Home',
                  ),

                  Tab(
                    iconMargin: EdgeInsets.only(bottom: 3),
                    icon: Icon(Icons.pending_actions_outlined),
                    text: 'Pending',
                  ),

                  Tab(
                    iconMargin: EdgeInsets.only(bottom: 3),
                    icon: Icon(Icons.refresh),
                    text: 'Revisions',
                  ),

                  Tab(
                    iconMargin: EdgeInsets.only(bottom: 3),
                    icon: Icon(Icons.library_add_check_sharp),
                    text: 'Completed',
                  ),
                ]),
            elevation: 0,
          ),

        body: const TabBarView(
            children: [
              AllProjects(),

              PendingProjects(),

              RevisionProjects(),

              CompletedProjects(),
        ]),


      ),
    );
  }
}
