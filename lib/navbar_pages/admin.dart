import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app_pages/edit_profile.dart';
import 'package:my_app/app_pages/reports.dart';
import 'package:my_app/app_pages/reset_password.dart';
import 'package:my_app/app_pages/Add_new_employee.dart';
import 'package:my_app/app_pages/sign_up.dart';
import 'package:my_app/employees_chat_list.dart';
import 'package:my_app/widgets/my_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_pages/sign_in.dart';
import '../app_pages/splash_screen.dart';
import '../common/sizes.dart';
import '../utilities/utils.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String currentUserImage = '';
  String? currentUserName;
  List allNewImagesAdded = [];

  @override
  void initState() {
    getImageUrl();
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: sizes.width5, top: sizes.height10),
              onPressed: (){
                logout();
              },
              icon: Icon(
                Icons.logout_outlined,
                color: const Color(0xff07aeaf),
                size: sizes.responsiveIconSize30,
              )
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: sizes.height5, right: sizes.width5),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius66),
                  border: Border.all(color: Colors.black, width: 1.1)),
              child: CircleAvatar(
                radius: sizes.responsiveImageRadius65,
                backgroundImage: currentUserImage != 'N/A'
                  ? NetworkImage(currentUserImage)
                    : null,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: sizes.height10, right: sizes.width5),
            child: Text(
              currentUserName.toString(),
              style: TextStyle(
                fontSize: sizes.responsiveFontSize20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Profile card
          MyCard(
            title: 'Profile',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
            },
            leading: const Icon(Icons.person_pin_outlined),
          ),

          //Register New Employee card
          MyCard(
            title: 'Register New Employee',
            leading: const Icon(Icons.people_outline_outlined),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewEmployee()));
            },
          ),

          //Reports card
          MyCard(
            title: 'Reports',
            leading: const Icon(Icons.event_note_outlined),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Reports()));
            },
          ),

          //Reset Password card
          MyCard(
            title: 'Reset Password',
            leading: const Icon(Icons.lock_outline),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword()));
            },
          ),

          //Chat Section card
          MyCard(
            title: 'Chat',
            leading: const Icon(Icons.chat),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeesChatList()));
            },
          ),


        ],
      ),
    );
  }

  // ImageUrl is get to display image
  void getImageUrl() async {
    User? currentUser = _auth.currentUser;
    try {
      List<Map<String, dynamic>> image = await StoreOnFireStore().getUser();
      Map<String, dynamic> userImage = image.firstWhere(
              (user) => user['Email'] == currentUser!.email,);
      if(userImage.isNotEmpty){
        String imgUrl = userImage['Users Image'];
        setState(() {
          currentUserImage = imgUrl;
        });
      }
    } catch (e) {
      print('Error fetching image: $e');
      Utils().toastMessage('Error fetching image: $e');
    }
  }

  //User Name is get to display current User name
  void getUserName() async {
    User? currentUser = _auth.currentUser;
    try {
      List<Map<String, dynamic>> name = await StoreOnFireStore().getUser();
      Map<String, dynamic> usersName = name.firstWhere(
            (user) => user['Email'] == currentUser!.email,);
      if(usersName.isNotEmpty){
        String userName = usersName['Full Name'];
        setState(() {
          currentUserName = userName;
        });
      }
    } catch (e) {
      print('Error fetching image: $e');
      Utils().toastMessage('Error fetching image: $e');
    }
  }

  // Logout krny k liy Function
  void logout () async {
    var sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool(SplashScreenState.keyLogin, false);

    Get.to( () => const SignIn());
  }
}
