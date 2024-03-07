import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app_pages/sign_up.dart';
import 'package:my_app/widgets/my_app_bar.dart';
import 'package:my_app/widgets/my_text.dart';
import 'package:my_app/widgets/my_text_field.dart';
import 'package:my_app/widgets/round_button.dart';

import '../utilities/utils.dart';

class AddNewEmployee extends StatefulWidget {
  const AddNewEmployee({super.key, });

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {

  final employeeDesignationController = TextEditingController();
  // Fetch employee names
  List employeesNamesList = [  ];
  String? valueChoose;
  List employeesEmailsList = [  ];
  String? chooseMail;
  List employeesNumbersList = [  ];
  String? chooseNumber;
  List employeesImagesList = [  ];
  String? chooseImage;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchEmployeeDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          iconSize: 18,
        ),
        title: 'Add New Employee',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 34),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.18,
              // height: 628,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height / 50,    //height given = 15.4
                        ),
                        //Employee name Selected
                        const MyText(text: 'Name'),
                        Container(
                          height: 55,
                          margin: const EdgeInsets.only(left: 20, right: 20,),
                          padding: const EdgeInsets.only(left: 11, right: 9, top: 3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade100, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: DropdownButton(
                            hint: const Text('Select Name', style: TextStyle(fontSize: 16)),
                            dropdownColor: Colors.white,
                            underline: SizedBox(),
                            iconSize: 30,
                            iconEnabledColor: Colors.grey.shade500,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                            items: employeesNamesList.map((valueItem) {
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

                        //Employee mail selected
                        const MyText(text: 'Enter Email'),
                        Container(
                          height: 55,
                          margin: const EdgeInsets.only(left: 20, right: 20,),
                          padding: const EdgeInsets.only(left: 11, right: 9, top: 3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade100, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: DropdownButton(
                            hint: Text('Select Email', style: TextStyle(fontSize: 16)),
                            dropdownColor: Colors.white,
                            underline: SizedBox(),
                            iconSize: 30,
                            iconEnabledColor: Colors.grey.shade500,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                            items: employeesEmailsList.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem, // Set the value to the individual value from the list.
                                child: Text(valueItem),
                              );
                            }).toList(),
                            value: chooseMail,
                            onChanged: (newValue) {
                              setState(() {
                                chooseMail = newValue as String?; // Make sure to set the valueChoose to the correct type.
                              });
                            },
                          ),
                        ),

                        //Employee Number Selected
                        const MyText(text: 'Phone Number'),
                        Container(
                          height: 55,
                          margin: const EdgeInsets.only(left: 20, right: 20,),
                          padding: const EdgeInsets.only(left: 11, right: 9, top: 3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade100, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: DropdownButton(
                            hint: Text('Select Number', style: TextStyle(fontSize: 16)),
                            dropdownColor: Colors.white,
                            underline: SizedBox(),
                            iconSize: 30,
                            iconEnabledColor: Colors.grey.shade500,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                            items: employeesNumbersList.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem, // Set the value to the individual value from the list.
                                child: Text(valueItem),
                              );
                            }).toList(),
                            value: chooseNumber,
                            onChanged: (newValue) {
                              setState(() {
                                chooseNumber = newValue as String?; // Make sure to set the valueChoose to the correct type.
                              });
                            },
                          ),
                        ),

                        //Employee Designation
                        const MyText(text: 'Designation'),
                        MyTextFormField(
                          controller: employeeDesignationController,
                          hintText: 'designation',
                          prefixIcon: Icon(Icons.policy_outlined, color: Colors.grey.shade400,),
                        ),

                        //Employee Image selection
                        const MyText(text: 'Image'),
                        Container(
                          height: 55,
                          margin: const EdgeInsets.only(left: 20, right: 20,),
                          padding: const EdgeInsets.only(left: 11, right: 9, top: 3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.shade100, width: 1),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: DropdownButton(
                            hint: const Text('Select Image', style: TextStyle(fontSize: 16)),
                            dropdownColor: Colors.white,
                            underline: const SizedBox(),
                            iconSize: 30,
                            iconEnabledColor: Colors.grey.shade500,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                            items: employeesImagesList.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem, // Set the value to the individual value from the list.
                                child: Text(valueItem),
                              );
                            }).toList(),
                            value: chooseImage,
                            onChanged: (newValue) {
                              setState(() {
                                chooseImage = newValue as String?; // Make sure to set the valueChoose to the correct type.
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 65,),
                    RoundButton(title: 'Add New Employee', onTap: addNewEmployee, loading: loading,)

                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  void fetchEmployeeDetails() async{
    try {
      List<Map<String, dynamic>> userDetails = await StoreOnFireStore().getUser();
      List employees = userDetails.map((user) => Employee(
          fullName: user['Full Name'],
          email: user['Email'],
          contactNumber: user['Contact Number'],
          image: user['Users Image']
      )).toList();
      setState(() {
        employeesNamesList = employees.map((employee) => employee.fullName).toList();
        employeesEmailsList = employees.map((employee) => employee.email).toList();
        employeesNumbersList = employees.map((employee) => employee.contactNumber).toList();
        employeesImagesList = employees.map((employee) => employee.image).toList();
      });
    } catch (e) {
      Utils().toastMessage('Error fetching names: $e');
    }
  }

  void addNewEmployee() async{
    setState(() {
      loading = true;
    });
    String Names = valueChoose ?? '';
    String Emails = chooseMail ?? '';
    String Numbers = chooseNumber ?? '';
    String designationEmp = employeeDesignationController.text;
    String Image = chooseImage ?? '';

    await AddNewEmployeeFireStore().addEmp(
        name: Names,
        email: Emails,
        phoneNumber: Numbers,
        designation: designationEmp,
        imageUrl: Image,
    );
    // Show a success message or navigate to another screen
    Utils().toastMessage('Employee added Successfully');
    setState(() {
      loading = false;  // Hide the loading indicator after the process is complete
    });
  }
}

class AddNewEmployeeFireStore{
  Future<String?> addEmp({
    required String name,
    required String email,
    required String phoneNumber,
    required String designation,
    required String imageUrl,
  }) async {
    try {
      CollectionReference projectCollection = FirebaseFirestore.instance.collection('addNewEmployee');
      // int milliSecond = DateTime.now().millisecondsSinceEpoch;'addNewEmployee'
      // String id = milliSecond.toString();
      await projectCollection.doc(email).set({
        'Full Name' : name,
        'Employee Email' : email,
        'Emp Phone Number' : phoneNumber,
        'Emp Designation' : designation,
        'Employee Image' : imageUrl,
        'timestamp' : FieldValue.serverTimestamp(),  //For Giving Order to projects step by step when added.
      });
    } catch (e) {
      print('Error adding user $e');
      return 'Error adding user $e';
    }
    return null;
  }
  Future<List<Map<String, dynamic>>> getAllEmpDetails() async{
    List<Map<String, dynamic>> employees = [];
    try {
      CollectionReference employee = FirebaseFirestore.instance.collection('addNewEmployee');
      final snapShot = await employee.get();

      for (var doc in snapShot.docs) {
        employees.add(doc.data() as Map<String, dynamic>);
      }
      return employees;
    } catch (e) {
      print('Error fetching all Project Details $e');
      throw e;
    }
  }
}

class Employee {
  String fullName;
  String email;
  String contactNumber;
  String image;

  Employee ({
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.image,
  });
}