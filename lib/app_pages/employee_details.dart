import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/app_pages/chat_screen.dart';
import 'package:my_app/app_pages/project_details.dart';
import 'package:my_app/app_pages/sign_up.dart';
import 'package:my_app/common/sizes.dart';
import 'package:my_app/controllers/employee_details_controller.dart';
import 'package:get/get.dart';
import 'package:my_app/widgets/round_button.dart';

import '../utilities/utils.dart';
import '../widgets/my_projects_in_progress.dart';
import 'add_new_project.dart';

class EmployeeDetails extends StatefulWidget {
  final Map<String, dynamic> empData;
  //final Map<String, int> employeeProjectsCount; // Add this line
  final Future<Map<String, int>> totalProjects;
  const EmployeeDetails(
      {super.key, required this.empData, required this.totalProjects});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  final EmployeeDetailsController controller =
      Get.put(EmployeeDetailsController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List usersAllIdsList = [];
  Map<String, dynamic> userData = {};
// for generating unique id for two different users
  String generateRoomId(String user1, String user2) {
    // Sort the user IDs or email addresses to ensure consistency
    List<String> sortedUsers = [user1, user2]..sort();
    return sortedUsers[0] + sortedUsers[1];
  }

  DateTime? joinedAt;

  List allNewImagesAdded = [];
  List<String> arrEarnings = [
    'April,2023',
    'March,2023',
    'Feb,2023',
  ];

  @override
  void initState() {
    super.initState();
    print("Total Projects Data: ${widget.totalProjects}");
    empJoiningDate();
    getImageUrl();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            iconSize: sizes.responsiveIconSize18,
          ),
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: sizes.height90,
                margin: EdgeInsets.symmetric(horizontal: sizes.width20),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(top: sizes.height5, left: sizes.width10),
                    leading: CircleAvatar(
                      radius: sizes.responsiveImageRadius30,
                      backgroundImage: NetworkImage(widget.empData.isNotEmpty
                          ? widget.empData['Employee Image']
                          : 'N/A'),
                    ),
                    title: Text(
                        widget.empData.isNotEmpty
                            ? widget.empData['Full Name']
                            : 'N/A',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        widget.empData.isNotEmpty
                            ? widget.empData['Emp Phone Number']
                            : 'N/A',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height20),
                child: const Text(
                  'Personal Info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Designation:   ${widget.empData.isNotEmpty ? widget.empData['Emp Designation'] : 'N/A'}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: Text(
                  'Joined:   ${joinedAt != null ? DateFormat('d MMM yyyy').format((joinedAt!)) : "N/A"}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: sizes.width20, top: sizes.height10),
                child: FutureBuilder<Map<String, int>>(
                  future: widget.totalProjects,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Total Projects: Loading...');
                    } else if (snapshot.hasError) {
                      return const Text('Total Projects: Error');
                    } else {
                      int projectsCount =
                          snapshot.data![widget.empData['Full Name']] ?? 0;
                      return Text(
                        'Total Projects: $projectsCount',
                        style: const TextStyle(color: Colors.black),
                      );
                    }
                  },
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.only(left: 18, top: 10),
              //   child: Text(
              //       'Total Projects: ${widget.totalProjects['Full Name'] ?? 0}',
              //style: TextStyle(color: Colors.black),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: sizes.height30, bottom: sizes.height20),
                color: Colors.white,
                child: TabBar(
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: sizes.width20,
                    ),
                    tabs: const [
                      Tab(
                        child: Text(
                          'Projects',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Earnings',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: sizes.height300,
                child: TabBarView(children: [
                  FutureBuilder<Map<String, int>>(
                    future: widget.totalProjects,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Total Projects: Error');
                      } else if (snapshot.hasData) {
                        int projectsCount =
                            snapshot.data![widget.empData['Full Name']] ?? 0;

                        return ListView.builder(
                            itemCount: projectsCount,
                            itemBuilder: (context, index) {
                              var imageUrl =
                                  allNewImagesAdded[index]['imageUrl'];
                              var projectTitle =
                                  allNewImagesAdded[index]['Project Title'];
                              var projectId =
                                  allNewImagesAdded[index]['Project Id'];
                              return MyProjectsInProgress(
                                title: projectTitle,
                                titleId: projectId,
                                imageUrl: imageUrl,
                                projectId: projectId,
                              );
                            },
                        );
                      } else {
                        return const Text('No projects available');
                      }
                    },
                  ),

                  //Second Child As there are two children
                  Container(
                    color: Colors.grey.shade100,
                    padding: EdgeInsets.symmetric(vertical: sizes.height12, horizontal: sizes.width13),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10)),
                          margin: EdgeInsets.symmetric(horizontal: sizes.width10, vertical: sizes.height10),
                          elevation: 0.2,
                          child: ListTile(
                            title: Text(arrEarnings[index]),
                            trailing: const Text('300'),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius20)),
                          ),
                        );
                      },
                      itemCount: 3,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: sizes.height5,
              ),
              RoundButton(title: 'Edit Employee Info', onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ));
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _twoButton(
    BuildContext context, {
    required button,
    required label,
    required String projectId,
  }) {
    return InkWell(
      onTap: () {
        print("projectId: $projectId");
        final currentUserId = _auth.currentUser?.email;
        final otherUserId = usersAllIdsList;
        //final secondUserId = currentUserId != otherUserId ;
        String roomId = generateRoomId(currentUserId!, otherUserId.toString());

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => button == 0
        //             ? ProjectDetails(
        //                 projectData: getSelectedProjectDetails(projectId),
        //                 updateIsChecked: (bool) {},
        //               )
        //             : ChatScreen(
        //                 receiverUserEmail: roomId,
        //                 //chatRoomId: roomId,
        //               )));

        controller.tapOnButton(button);
      },
      child: Container(
        width: 125,
        height: 50,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: controller.currentButton.value == button
              ? const Color(0xff07aeaf)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: controller.currentButton.value == button
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void empJoiningDate() {
    setState(() {
      if (joinedAt == null) {
        var createdAtMillies = DateTime.now().millisecondsSinceEpoch;
        joinedAt = DateTime.fromMillisecondsSinceEpoch(createdAtMillies);
      }
    });
  }

  void getImageUrl() async {
    try {
      List<Map<String, dynamic>> image =
          await StoreNewProjectFireStore().getAllDetails();
      setState(() {
        allNewImagesAdded = image;
      });
    } catch (e) {
      print('Error fetching names: $e');
      Utils().toastMessage('Error fetching names: $e');
    }
  }

  Map<String, dynamic> getSelectedProjectDetails(String projectId) {
    for (var projectData in allNewImagesAdded) {
      if (projectData['Project Id'] == projectId) {
        return projectData;
      }
    }
    return {}; // Return an empty map if the index is invalid
  }

  void getUserDetails() async {
    try {
      List<Map<String, dynamic>> chatIds =
          await StoreNewProjectFireStore().getAllDetails();
      List Ids = chatIds.map((user) => user['AssignedProId']).toList();
      setState(() {
        usersAllIdsList = Ids;
      });
    } catch (e) {
      print('Error fetching assignedIds : $e');
    }
  }
}

// Push Notifications pr kam krna h k unko kesy handle krty hn.
