import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 15
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
            iconSize: 20,
          ),
        ),
        leadingWidth: 40,
        title: const Text(
          'Reports',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.all(10),
            elevation: 0,
            child: ListTile(
              title: const Text('April,2023'),
              trailing: const Icon(Icons.navigate_next_outlined),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
          );
        },
        itemCount: 5,
        ),
      ),
    );
  }
}
