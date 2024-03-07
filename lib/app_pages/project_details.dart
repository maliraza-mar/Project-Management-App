import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utilities/utils.dart';
import 'add_new_project.dart';

class ProjectDetails extends StatefulWidget {
  final Map<String, dynamic> projectData; // Add the final keyword here
  final Function(bool) updateIsChecked;
  const ProjectDetails({super.key, required this.projectData, required this.updateIsChecked});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {

  int currentId = 1001;
  DateTime? createdAt;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    creationDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          iconSize: 18,
        ),
        title: const Text(
          'Project Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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

                  widget.projectData.isNotEmpty && widget.projectData.containsKey('imageUrl')
                      ? Uri.tryParse(widget.projectData['imageUrl']) != null  //if it is a valid URL using the Uri.tryParse method
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          widget.projectData['imageUrl'],
                          width: 100,
                          height: 100,
                        ),
                      )
                      : const Text('Invalid Image URL')
                      : const Text('No Image Available'),

                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            '${widget.projectData.isNotEmpty ? widget.projectData['Project Title'] : 'N/A'}',
                            // '${allProjects.isNotEmpty ? allProjects.last['Project Title'] : 'N/A'}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'ProjectID:  ${widget.projectData.isNotEmpty ? widget.projectData['Project Id'] : 'N/A'}',
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Project Info part here
            const Padding(
              padding: EdgeInsets.only(
                left: 18,
                //top: 5
              ),
              child: Text(
                'Project Info',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text(
                'Created At:   ${createdAt != null ? DateFormat('d MMM yyyy').format((createdAt!)) : "N/A"}',
                // 'Created At:   ${createdAt != null ? DateFormat('d MMM yyyy').format(createdAt!) : "N/A"}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text(
                'Deadline:   ${widget.projectData.isNotEmpty ? widget.projectData['Deadline'] : "N/A"}',
                // 'Deadline:   ${allProjects.isNotEmpty ? allProjects.last['Deadline'] : "N/A"}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text(
                'Budget:   ${widget.projectData.isNotEmpty ? widget.projectData['Budget'] : 'N/A'}',
                // 'Budget:   ${allProjects.isNotEmpty ? allProjects.last['Budget'] : 'N/A'}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text(
                'Status:   ${isChecked == true ? 'Completed' : 'In Progress'}',
                style: const TextStyle(color: Colors.black),
              ),
            ),

            //Employee Info Part Here
            const Padding(
              padding: EdgeInsets.only(left: 18, top: 15),
              child: Text(
                'Employee Info',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text(
                'Name:   ${widget.projectData.isNotEmpty ? widget.projectData['Employee Name'] : 'N/A'}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: Text(
                'Out Source:  ${widget.projectData.isNotEmpty ? widget.projectData['Budget'] : 'N/A'}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 18,),
                  child: Text(
                    'Project Completed?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Checkbox(
                    value: isChecked,
                    activeColor: Colors.black,
                    onChanged: isChecked ? null
                        : (newValue){
                      setState(() {
                        isChecked = newValue!;
                      });
                      if (isChecked) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: const Color(0xff07aeaf)
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isChecked = false;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel', style: TextStyle(color: Colors.black),)
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: const Color(0xff07aeaf)
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isChecked = true;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes', style: TextStyle(color: Colors.black,)),
                                  ),
                                ],
                                title: const Text('Project Completed?'),
                                contentPadding: const EdgeInsets.all(20),
                                content: const Text('Have you completed the project?'),
                              );
                            },
                        );
                        widget.updateIsChecked(isChecked);
                      }
                    }
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.only(left: 18, top: 20),
              child: Text(
                'Instructions',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
            ),

            //TextForm Field here for a message from user
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                minLines: 4,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'enter a message here',
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

            //TextButton of Update Status here
            const SizedBox(
              height: 68,
            ),
            Center(
              child: Container(
                width: 320,
                height: 52,
                decoration: BoxDecoration(
                    color: const Color(0xff07aeaf),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit project Info',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

      //Created At, becomes to the date when project is created.
  void creationDate() {
    setState(() {
      if (createdAt == null) {
        var createdAtMillies = DateTime.now().millisecondsSinceEpoch;
        createdAt = DateTime.fromMillisecondsSinceEpoch(createdAtMillies);
      }
    });
  }

  void boxChecked() {
    if (isChecked == true) {
      AlertDialog(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Yes'),
          ),
          TextButton(
              onPressed: () {},
              child: Text('Cancel')
          ),
        ],
        title: Text('Project Completed?'),
        contentPadding: EdgeInsets.all(20),
        content: Text('Have you completed the project?'),
      );
    }
  }


}
