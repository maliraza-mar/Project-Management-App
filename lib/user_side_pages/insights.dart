import 'package:flutter/material.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          automaticallyImplyLeading: false,
          title: const Text('Insights', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
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
          elevation: 0,
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 320,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

            //Text h Income Report ka
            const Padding(
              padding: EdgeInsets.only(top: 15, left: 18),
              child: Text('Income Report',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22, color: Colors.black),
              ),
            ),

            //Graph Chart or Bar Chart wala part h
            const TabBar(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                tabs: [

              Tab(child: Text('Last Month', style: TextStyle(color: Colors.black),),),

              Tab(child: Text('3M', style: TextStyle(color: Colors.black),),),

              Tab(child: Text('6M', style: TextStyle(color: Colors.black),),),

              Tab(child: Text('Year', style: TextStyle(color: Colors.black),),),

              Tab(child: Text('All', style: TextStyle(color: Colors.black),),),
            ])
          ],
        ),
      ),
    );
  }
}
