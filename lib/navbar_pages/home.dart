import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/common/sizes.dart';
import 'package:my_app/widgets/employee_image_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus(true);
  }

  void setStatus(bool status) async{
    await _firestore.collection('users').doc(_auth.currentUser?.email).update({
      "Status" : status
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus(true);
    } else {
      // offline
      setStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Employee Header name and Employees with images
            Padding(
              padding: EdgeInsets.only(
                top: sizes.height30,                 //top = 30.9
                left: sizes.width24,                 //left = 24
                bottom: sizes.height15               //bottom = 15
              ),
              child: Text(
                'Employees',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sizes.responsiveFontSize17,
                ),
              ),
            ),
            Container(
              height: sizes.height110,                //height approx. = 110.3
              margin: EdgeInsets.symmetric(
                horizontal: sizes.width13,        //horizontal approx. = 13
              ),
              child: ListView.builder(
                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const EmployeeImageCircleAvatar();
                }),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: sizes.width24,      //left = 24
                top: sizes.height15,       //top = 15
              ),
              child: Text(
                'Projects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizes.responsiveFontSize17,
                ),
              ),
            ),

            //Date & Year selection
            Container(
              height: sizes.height48,
              width: sizes.width144,             //width = 144
              margin: EdgeInsets.only(
                left: sizes.width20,            //left = 20,
                bottom: sizes.height20,      //bottom = 20
                top: sizes.height20,        //top = 20
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius15),      //responsiveRadius = 15
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: sizes.width20,            //left = 20
                    ),
                    child: const Text(
                      'May 2023',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: sizes.width20,            //left = 20
                    ),
                    child: const Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ],
              ),
            ),

            //GridView for Pending, In Progress, Revisions, Completed.
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: sizes.width12, vertical: sizes.height12),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.10, // width and height given is = 360 and 365
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: sizes.width9,        //horizontal approx. = 9
                      vertical: sizes.height7,        //vertical approx. = 7.7
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: sizes.height26,        //top = 26
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff07aeaf),
                      borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius20),     //radius = 20
                    ),
                    child: Column(
                      children: [
                        Text('12',
                          style: TextStyle(
                              fontSize: sizes.responsiveFontSize40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Text('Pending',
                          style: TextStyle(
                              color: Colors.white),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
