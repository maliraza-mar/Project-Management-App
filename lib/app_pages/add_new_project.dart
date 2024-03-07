import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/app_pages/sign_up.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/common/sizes.dart';
import 'package:my_app/widgets/my_app_bar.dart';
import 'package:my_app/widgets/my_text.dart';
import 'package:my_app/widgets/my_text_field.dart';
import 'package:my_app/widgets/round_button.dart';
import '../utilities/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:permission_handler/permission_handler.dart';
import 'project_details.dart';


class AddNewProject extends StatefulWidget {
  const AddNewProject({super.key});

  @override
  State<AddNewProject> createState() => AddNewProjectState();
}

class AddNewProjectState extends State<AddNewProject> {

  final titleController = TextEditingController();
  final projectIdController = TextEditingController();
  final budgetController = TextEditingController();

  // Fetch employee names
  List employeesList = [  ];
  String? valueChoose;

  // Pick image
  File? _image;
  final picker = ImagePicker();
  String? selectedFileName; // Variable to store the selected file name

  bool loading = false;
  Map<String, int> totalProjects = {};
  //DatePicked
  DateTime? selectedDate; // Declare the selectedDate variable

  @override
  void initState() {
    super.initState();
    fetchEmployeesList(); // Fetch names from Firestore on widget initialization
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: const Color(0xff07aeaf),
      appBar: MyAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          iconSize: sizes.responsiveIconSize18,       //18
        ),
        title: 'Add New Project',
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: sizes.height10),
            child: Container(
              height: sizes.height677,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sizes.responsiveBorderRadius40),
                      topLeft: Radius.circular(sizes.responsiveBorderRadius40)
                  )
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizes.height10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizes.height10,),
                        //Project Title Area
                        const MyText(text: 'Project Title'),
                        MyTextFormField(controller: titleController, hintText: 'Project Title'),

                        //Giving unique id to a project Area
                        const MyText(text: 'Project ID'),
                        MyTextFormField(controller: projectIdController, hintText: 'unique project id i.e. 101'),

                        // Budget Section
                        const MyText(text: 'Budget'),
                        MyTextFormField(controller: budgetController, hintText: '\$500'),

                        //Deadline of project section
                        const MyText(text: 'Deadline'),
                        Container(
                          height: sizes.height55,
                          margin: EdgeInsets.symmetric(horizontal: sizes.width20),
                          //padding: EdgeInsets.only(top: sizes.height5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: sizes.width12),
                                child: Text(
                                  selectedDate != null
                                      ? DateFormat('d MMM yyyy').format(selectedDate!)
                                      : 'Select Date',
                                  style: TextStyle(
                                      color: selectedDate != null ? Colors.black : Colors.grey.shade600,
                                      fontSize: sizes.responsiveFontSize16,
                                  ),
                                ),
                              ),
                              IconButton(
                                  padding: EdgeInsets.only(right: sizes.width5),
                                  onPressed: () {
                                    datePicked();
                                  },
                                  icon: Icon(Icons.calendar_month_outlined, color: Colors.grey.shade400,)
                              )
                            ],
                          ),
                        ),

                        //DropdownButton area means Employee Selection Section
                        const MyText(text: 'Select Employee'),
                        Container(
                          height: sizes.height55,
                          margin: EdgeInsets.symmetric(horizontal: sizes.width20,),
                          padding: EdgeInsets.only(
                            left: sizes.width12,
                            right: sizes.width5,
                            top: sizes.height5,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade100,),
                              borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10)
                          ),
                          child: DropdownButton(
                            hint: Text('Select Employee',
                              style: TextStyle(
                                fontSize: sizes.responsiveFontSize16,
                              ),
                            ),
                            dropdownColor: Colors.white,
                            underline: const SizedBox(),
                            iconSize: sizes.responsiveIconSize30,
                            iconEnabledColor: Colors.grey.shade500,
                            isExpanded: true,
                            style: TextStyle(color: Colors.black, fontSize: sizes.responsiveFontSize16),
                            items: employeesList.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem, // Set the value to the individual value from the list.
                                child: Text(valueItem),
                              );
                            }).toList(),
                            value: valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoose = newValue as String?; // Make sure to set the valueChoose to the correct type.
                              });
                            },
                          ),
                        ),

                        // Attachment Area means image picking area
                        const MyText(text: 'Attachment'),
                        Container(
                          height: sizes.height55,
                          margin: EdgeInsets.symmetric(horizontal: sizes.width20,),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  getGalleryImage();
                                },
                                child: Container(
                                  height: sizes.height37,
                                  width: sizes.width124,
                                  margin: EdgeInsets.only(left: sizes.width8),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff07aeaf),
                                      borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius6)
                                  ),
                                  child: Center(
                                    child: Text( 'Choose File',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: sizes.responsiveFontSize17),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: sizes.width8),
                                child: Text(
                                  selectedFileName != null ?
                                  (selectedFileName!.length > 10 ?
                                  '${selectedFileName!.substring(0, 10)}...' :
                                  selectedFileName!) : 'File name', // Display selected file name or 'File name'
                                  // if none is selected
                                  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                  style: TextStyle(color: Colors.black, fontSize: sizes.responsiveFontSize17),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),


                    RoundButton(title: 'Add', onTap: addNewProject, loading: loading,),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Employee names are displayed in the dropdownButton
  void fetchEmployeesList() async {
    try {
      List<Map<String, dynamic>> userDetails = await StoreOnFireStore().getUser();
      List names = userDetails.map((user) => user['Full Name']).toList();
      setState(() {
        employeesList = names; // Convert the string to a list containing only that string.
      });
    } catch (e) {
      Utils().toastMessage('Error fetching names: $e');
    }
  }

  // Image is selected from users mobile uploaded and showed uploaded and stored on firestore
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  Future getGalleryImage() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        selectedFileName = pickedFile.name;
      } else {
        print('no image picked');
      }
    });
  }

  Future uploadImage() async {
    try{

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.
      ref('/newprojectimages/${DateTime.now().millisecondsSinceEpoch}');
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

      final snapShot = await uploadTask;
      final downloadUrl = await snapShot.ref.getDownloadURL();

      Utils().toastMessage('Image Uploaded Successfully');
      return downloadUrl;

    } catch (e) {
      Utils().toastMessage('Image Upload Failed: $e');
      return 'Image Upload Failed: $e';
    }
  }

  Future datePicked() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(3000),
    );

    setState(() {
      if (pickDate != null) {
        selectedDate = pickDate;
      }
    });
  }

  void addNewProject() async{
    setState(() {
      loading = true; // Show the loading indicator as soon as the process starts
    });
    String title = titleController.text;
    String projectId = projectIdController.text;
    //Check if the project ID already exists
    bool projectIdExists = await checkProjectIdExists(projectId);
    if (projectIdExists) {
      Utils().toastMessage('Project Id already Exists');
      // Fetch the last added Project ID
      String? lastAddedProjectId = await getLastAddedProjectId();
      if (lastAddedProjectId != null) {
        int nextProjectId = int.parse(lastAddedProjectId) + 1;
        projectIdController.text = nextProjectId.toString();
        // Display the message in SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Suggested Project ID: $nextProjectId'))
        );
      }
      return;
    }
    String budget = budgetController.text;
    String deadline = selectedDate != null ? DateFormat('d MMM yyyy').format(selectedDate!) : '';
    String selectedEmployee = valueChoose ?? '' ;
    String attachment = selectedFileName ?? '' ;

    String imageUrl = '';
    bool uploadSuccess = false; // Track the success of image upload
    if (_image != null) {
      imageUrl = await uploadImage();
      uploadSuccess = true;
    }
    if (!uploadSuccess) {
      // Handle the case where image upload failed
      Utils().toastMessage('Image upload failed');
      return;
    }

    String projectAssignedId = generateProjectAssignId(selectedEmployee);  //Assigned Unique Id

    await StoreNewProjectFireStore().addProject(
        title: title,
        projectId: projectId,
        budget: budget,
        deadline: deadline,
        selectEmployee: selectedEmployee,
        attachment: attachment,
        imageUrl: imageUrl,
        assignedManProId: projectAssignedId
    );

    Utils().toastMessage('Project added successfully');
    setState(() {
      loading = false;  // Hide the loading indicator after the process is complete
    });
  }

  //func for assiging id to a person to whom project is assigned
  String generateProjectAssignId(String userName) {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return '$userName-$timestamp' ;
  }

  // Function to check if project Id already exists
  Future<bool> checkProjectIdExists(String projectId) async{
    try {
      CollectionReference projectCollection = FirebaseFirestore.instance.collection('addNewProject');
      final snapShot = await projectCollection.where('Project Id', isEqualTo: projectId).get();
      return snapShot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking project ID: $e');
      return false; // Assume project ID doesn't exist on error
    }
  }

  //Function to check what is the last id that has added in the project.
  Future<String?> getLastAddedProjectId() async{
    try{
      CollectionReference projectCollection = FirebaseFirestore.instance.collection('addNewProject');
      final snapShot = await projectCollection.orderBy('Project Id', descending: true).limit(1).get();
      if (snapShot.docs.isNotEmpty) {
        return snapShot.docs.first['Project Id'];
      }
      return null;
    } catch (e) {
      print('Error fetching last added project Id $e');
      return null;
    }
  }

}

class StoreNewProjectFireStore{
  Future<String?> addProject({
    required String title,
    required String projectId,
    required String budget,
    required String deadline,
    required String selectEmployee,
    required String attachment,
    required String imageUrl,
    required String assignedManProId
  }) async {
    try {
      CollectionReference projectCollection = FirebaseFirestore.instance.collection('addNewProject');
      await projectCollection.doc(title).set({
        'Project Title' : title,
        'Project Id' : projectId,
        'Budget' : budget,
        'Deadline' : deadline,
        'Full Name' : selectEmployee,
        'Attachment' : attachment,
        'imageUrl' : imageUrl,
        'timestamp' : FieldValue.serverTimestamp(),  //For Giving Order to projects step by step when added.
        'AssignedProId' : assignedManProId,
      });
    } catch (e) {
      print('Error adding user $e');
      return 'Error adding user $e';
    }
    return 'Success';
  }
  Future<List<Map<String, dynamic>>> getAllDetails() async{
    List<Map<String, dynamic>> projects = [];
    try{
      CollectionReference projectCollection = FirebaseFirestore.instance.collection('addNewProject');
      final snapShot = await projectCollection.orderBy('timestamp', descending: false).get();

      for (var doc in snapShot.docs) {
        projects.add(doc.data() as Map<String, dynamic>);
      }
      return projects;
    } catch (e) {
      print('Error fetching all Project Details $e');
      throw e;
    }
  }

}
