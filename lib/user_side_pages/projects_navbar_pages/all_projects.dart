import 'package:flutter/material.dart';

class AllProjects extends StatefulWidget {
  const AllProjects({super.key});

  @override
  State<AllProjects> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: 320,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xff07aeaf)
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 10, top: 35),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('20', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),),
                      ),
                      Text('Completed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                Text('|', style: TextStyle(color: Colors.white, fontSize: 70),),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 15, top: 35),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('02', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),),
                      ),
                      Text('Missed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                Text('|', style: TextStyle(color: Colors.white, fontSize: 70),),

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 15, top: 35),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('12', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),),
                      ),
                      Text('To Do', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 100,
            width: 320,
            margin: const EdgeInsets.only(
                top: 9,
                left: 20,
                right: 15,
                bottom: 15
            ),
            decoration:BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                          width: 70,
                          height: 70,),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20, top: 10
                                  ),
                                  child: Text('New House', style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 75, top: 10),
                                  child: Text('ID:  1001', style: TextStyle(fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: EdgeInsets.only(right: 106),
                              child: Text('Validity: 1 day', style: TextStyle(fontSize: 11),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 20, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.orangeAccent, size: 13,),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Text('Pending'),
                          ),
                        ],
                      ),
                      Text('July 15, 2023  02:05 AM', style: TextStyle(fontSize: 11),)
                    ],
                  ),
                )

              ],
            ),
          ),

          Container(
            height: 100,
            width: 320,
            margin: const EdgeInsets.only(
                top: 4,
                left: 20,
                right: 15,
                bottom: 15
            ),
            decoration:BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                          width: 70,
                          height: 70,),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10
                                  ),
                                  child: Text('New House', style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 75, top: 10),
                                  child: Text('ID:  1001', style: TextStyle(fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: EdgeInsets.only(right: 106),
                              child: Text('Validity: 1 day', style: TextStyle(fontSize: 11),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 20, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.redAccent, size: 13,),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Text('Revisions'),
                          ),
                        ],
                      ),
                      Text('July 15, 2023  02:05 AM', style: TextStyle(fontSize: 11),)
                    ],
                  ),
                )

              ],
            ),
          ),

          Container(
            height: 100,
            width: 320,
            margin: const EdgeInsets.only(
                top: 4,
                left: 20,
                right: 15,
                bottom: 15
            ),
            decoration:BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                          width: 70,
                          height: 70,),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, top: 10
                                  ),
                                  child: Text('New House', style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 75, top: 10),
                                  child: Text('ID:  1001', style: TextStyle(fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: EdgeInsets.only(right: 106),
                              child: Text('Validity: 1 day', style: TextStyle(fontSize: 11),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 20, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.green, size: 13,),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Text('Completed'),
                          ),
                        ],
                      ),
                      Text('July 15, 2023  02:05 AM', style: TextStyle(fontSize: 11),)
                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
