import 'package:flutter/material.dart';

class ProjectsDetails extends StatefulWidget {
  const ProjectsDetails({super.key});

  @override
  State<ProjectsDetails> createState() => _ProjectsDetailsState();
}

class _ProjectsDetailsState extends State<ProjectsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
          iconSize: 18,
        ),
        title: const Text('Project Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                      width: 110,
                      height: 115,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 45
                          ),
                          child: Text('New House', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 45
                          ),
                          child: Text('Project ID:  1001', style: TextStyle(fontSize: 12),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            //Project Info part here
            const Padding(
              padding: EdgeInsets.only(
                left: 18,
                //top: 5
              ),
              child: Text('Project Info',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17),),
            ),

            const Padding(
              padding: EdgeInsets.only(
                  left: 18,
                  top: 10
              ),
              child: Text('Created At:   30-June-2023', style: TextStyle(color: Colors.black),),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 18,
                  top: 10
              ),
              child: Text('Deadline:   30-June-2023', style: TextStyle(color: Colors.black),),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 18,
                  top: 10
              ),
              child: Text('Budget:   500', style: TextStyle(color: Colors.black),),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: 18,
                  top: 10
              ),
              child: Text('Status:   Completed', style: TextStyle(color: Colors.black),),
            ),

            const Padding(
              padding: EdgeInsets.only(
                  left: 18,
                  top: 50
              ),
              child: Text('Instructions',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),),
            ),

            //TextForm Field here for a message from user
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                minLines: 6,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has "
                      "been the industry's standard dummy text ever since the 1500s.",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
