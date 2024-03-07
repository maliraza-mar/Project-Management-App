import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/widgets/my_app_bar.dart';
import 'package:my_app/widgets/my_text.dart';
import 'package:my_app/widgets/my_text_field.dart';

import '../common/sizes.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeEmailController = TextEditingController();
  final TextEditingController employeeContactController = TextEditingController();

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
          iconSize: sizes.responsiveIconSize18,
        ),
        title: 'Edit Profile',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: sizes.height100),
            child: Container(
              height: sizes.height588,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sizes.responsiveBorderRadius40),
                      topLeft: Radius.circular(sizes.responsiveBorderRadius40),
                  ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: sizes.height20,),
                    child: Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_640.png'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40,),

                  //Employee Name
                  const MyText(text: 'Name'),
                  MyTextFormField(
                    controller: employeeNameController,
                    hintText: 'Employee name',
                    prefixIcon: Icon(Icons.person_outline, color: Colors.grey.shade400,),
                  ),

                  //Employee Email
                  const MyText(text: 'Enter Email'),
                  MyTextFormField(
                    controller: employeeEmailController,
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade400,),
                  ),

                  //Employee Phone Number
                  const MyText(text: 'Phone Number'),
                  MyTextFormField(
                    controller: employeeContactController,
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.call, color: Colors.grey.shade400,),
                  ),

                  //Update Button
                  const SizedBox(height: 75,),
                  Center(
                    child: Container(
                      width: 320,
                      height: 52,
                      decoration: BoxDecoration(
                          color: const Color(0xff07aeaf),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
