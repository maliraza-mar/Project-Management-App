import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/app_pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Connectivity().checkConnectivity();
  Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBp3v7MSl1sedG5xwA2FgiqynjMXtX4e98",
        appId: "1:679456737875:web:01dbdb038ffe3a05b194a6",
        messagingSenderId: "679456737875",
        projectId: "my-app-f3d46"
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}



//https://youtu.be/JhcawTfby_Q?si=3t0HfSJbtfpxr8iO
//Cached Network Image