import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_pages/sign_in.dart';
import '../app_pages/splash_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                padding: const EdgeInsets.only(right: 20, top: 10),
                onPressed: (){
                  logout();
                },
                icon: const Icon(Icons.logout_outlined, color: Color(0xff07aeaf), size: 30,)
            ),
          ],
          backgroundColor: Colors.grey.shade100,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              height: 140,
              width: 320,
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color(0xff07aeaf),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Text('Hi Ali Raza,', style: TextStyle(color: Colors.white, fontSize: 23),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30, top: 10),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_640.png'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 35, left: 9),
                        child: Column(
                          children: [
                            Text('Jul 26, 2023', style: TextStyle(fontSize: 18, color: Colors.white),),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text('6 task assigned', style: TextStyle(fontSize: 12, color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        margin: const EdgeInsets.only(top: 40, right: 34),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white, width: 3),

                        ),
                        child: const Center(child: Text('0/6', style: TextStyle(color: Colors.white, fontSize: 13),)),
                      )
                    ],
                  )
                ],
              ),
            ),

            Row(
              children: [
                Container(
                  height: 100,
                  width: 152,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: .5,
                        offset: const Offset(1, 1)
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 5),
                            child: Icon(Icons.rocket_launch_sharp, size: 30, color: Colors.grey.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 13),
                            child: Text('Actions',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7, left: 5, right: 2),
                        child: Text('System generated counter measures & control actions assigned to the user.',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 152,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: .5,
                            offset: const Offset(1, 1)
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 5,),
                            child: Icon(Icons.people_outline, size: 30, color: Colors.grey.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 13),
                            child: Text('Teams',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7, left: 5, right: 5),
                        child: Text('Horizontal and vertical communications system for team.',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 18,),
            Row(
              children: [
                Container(
                  height: 100,
                  width: 152,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: .5,
                            offset: const Offset(1, 1)
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 5),
                            child: Icon(Icons.notifications_none_outlined, size: 30, color: Colors.grey.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 13),
                            child: Text('Notifications',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7, left: 5, right: 2),
                        child: Text('Important notifications from management, consumer, team etc.',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 152,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: .5,
                            offset: const Offset(1, 1)
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 5,),
                            child: Icon(Icons.my_library_books, size: 30, color: Colors.grey.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 13),
                            child: Text('E-Docs',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7, left: 5, right: 5),
                        child: Text('Projects related documents, Pdfs, information etc.',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30,),
            Container(
              height: 126,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15, left: 10),
                    child: Text('Projects',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            const Text('20', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                            Text('Completed', style: TextStyle(color: Colors.grey.shade500),)
                          ],
                        ),
                      ),

                      Text('|', style: TextStyle(color: Colors.grey.shade300, fontSize: 50),),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            const Text('02', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                            Text('Missed', style: TextStyle(color: Colors.grey.shade500),)
                          ],
                        ),
                      ),

                      Text('|', style: TextStyle(color: Colors.grey.shade300, fontSize: 50),),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Column(
                          children: [
                            const Text('12', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                            Text('To do', style: TextStyle(color: Colors.grey.shade500),)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Logout krny k liy Function
  void logout () async {
    var sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool(SplashScreenState.keyLogin, false);

    Get.to( () => const SignIn());
  }
}
