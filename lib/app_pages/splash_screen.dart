import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/app_pages/sign_in.dart';
import 'package:my_app/navbar_page.dart';
import 'package:my_app/user_side_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../controllers/sign_in_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  final SignInController controller = Get.put(SignInController());

  static const String keyLogin = "login";
  static const String isAdmin = "isAdmin";

  @override
  void initState() {
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: const Center(
          child: Text(
            'Logo',
            style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
        ),
      )),
    );
  }

  //SharedPreference k liy Function
  void whereToGo () async{

    var sharedPreference = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPreference.getBool(keyLogin);
    var isLastVisited = sharedPreference.getBool(isAdmin);

    Timer(const Duration(seconds: 2), () {

      if (isLoggedIn!= null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context)
          => isLastVisited == true ? const NavBarPage() : const UserSidePages()
          ));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const SignIn()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SignIn()));
      }

    });
  }
}
