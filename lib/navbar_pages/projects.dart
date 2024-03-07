import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app_pages/add_new_project.dart';
import 'package:my_app/common/sizes.dart';
import 'package:my_app/controllers/projects_controller.dart';
import 'package:get/get.dart';
import 'package:my_app/widgets/my_projects_in_progress.dart';
import '../utilities/utils.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final ProjectsController controller = Get.put(ProjectsController());
  int currentId = 1001;
  bool isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List usersAllIdsList = [];
  Map<String, dynamic> userData = {};

  // for generating unique id for two different users
  String generateRoomId(String user1, String user2) {
    // Sort the user IDs or email addresses to ensure consistency
    List<String> sortedUsers = [user1, user2]..sort();
    return '${sortedUsers[0]}_${sortedUsers[1]}';
  }

  List allNewImagesAdded = [];

  @override
  void initState() {
    final imageUrl = allNewImagesAdded;
    super.initState();
    getImageUrl();
    getUserDetails();
    //loadImage(imageUrl.toString());
    print('UserData is : $userData');
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text(
            'Projects',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade100,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: sizes.height10,
          ), //top = 10
          child: Column(
            children: [
              //Tabs for Project and Completed
              Container(
                color: Colors.white,
                child: TabBar(
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: sizes.width20, //left = 20
                    ),
                    tabs: const [
                      Tab(
                        child: Text(
                          'In Progress',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Completed',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ]),
              ),

              SizedBox(
                height: sizes.height510,
                child: TabBarView(children: [
                  //Projects tab
                  ListView.builder(
                      itemCount: isLoading ? 1 : allNewImagesAdded.length,
                      itemBuilder: (context, index) {
                        //var projectData = allNewImagesAdded[index];
                        if (isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var imageUrl = allNewImagesAdded[index]['imageUrl'];
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
                        }
                      }),

                  // Project Completed Section
                  ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                           children: [
                            Container(
                              height: sizes.height220,                       //height approx. = 220.6
                              width: sizes.width320,                       //height approx. = 320
                              margin: EdgeInsets.only(
                                top: sizes.height20,               //top = 20
                                left: sizes.width20,                  //left = 20
                                right: sizes.width20,                  //left = 20
                                bottom: sizes.height20,               //top = 20
                              ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 10),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius20),//borderRadius = 20
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: sizes.height5,                //top = 5
                                      left: sizes.width20,                  //left = 20
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                            BorderRadius.circular(sizes.responsiveBorderRadius30),//borderRadius = 30
                                          child: Image.network(
                                            'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                                            width: sizes.width100,                       //width approx. = 100
                                            height: sizes.height100,                    //height approx. = 100
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: sizes.height15,                //top = 15
                                            left: sizes.width20,                  //left = 20
                                          ),
                                          child: Column(
                                            children: [
                                              const Text('New House'),
                                              SizedBox(
                                                height: sizes.height5,                //height = 5
                                              ),
                                              const Text('ID:  1001',)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                      left: 20,
                                    ),
                                    child: Text('Status :  Completed'),
                                  ),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _twoButton(
                                          context,
                                          button: 0,
                                          label: 'Details',
                                          projectId: index.toString(),
                                        ),
                                        _twoButton(
                                          context,
                                          button: 1,
                                          label: 'Message',
                                          projectId: index.toString(),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ));
                      })
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _twoButton(BuildContext context, {required button, required label, required String projectId}) {
    return InkWell(
      onTap: () {
        print("projectId: $projectId");
        final currentUserId = _auth.currentUser?.email;
        final otherUserId = usersAllIdsList;
        //final secondUserId = currentUserId != otherUserId;
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
        //                 // chatRoomId: roomId,
        //               )));

        controller.tapOnButton(button);
      },
      child: Container(
        width: 125,
        height: 50,
        margin: const EdgeInsets.only(top: 20),
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

  // ImageUrl is get to display image
  void getImageUrl() async {
    try {
      List<Map<String, dynamic>> image =
          await StoreNewProjectFireStore().getAllDetails();
      setState(() {
        allNewImagesAdded = image;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching names: $e');
      Utils().toastMessage('Error fetching names: $e');
    }
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

  // Future loadImage(String imageUrl) async{
  //   try{
  //     final image = NetworkImage(imageUrl);
  //
  //     image.resolve(ImageConfiguration()).addListener(
  //         ImageStreamListener(
  //               (info, synchronousCall) {},
  //           onError: (dynamic exception, StackTrace? stackTrace){
  //             print('Error while loading image : $exception');
  //           },
  //         )
  //     );
  //
  //     return Image(image: image);
  //   } catch (e) {
  //     print('Error loading image : $e');
  //     return Text('');
  //   }
  // }

  // void getUserDetails() async {
  //   try {
  //     final userDoc = await _firestore.collection('addNewProject').doc().get();
  //     if (userDoc.exists) {
  //       final userDataFromFirestore = userDoc.data() as Map<String, dynamic>;
  //       setState(() {
  //         userData = userDataFromFirestore;
  //       });
  //       print('Fetched User Data is : $userDataFromFirestore');
  //       print('UserssData in function is : $userData');
  //     }
  //   } catch (e) {
  //     print('Error fetching names: $e');
  //   }
  // }

  Map<String, dynamic> getSelectedProjectDetails(String projectId) {
    for (var projectData in allNewImagesAdded) {
      if (projectData['Project Id'] == projectId) {
        return projectData;
      }
    }
    return {}; // Return an empty map if the index is invalid
  }


}
