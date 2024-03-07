import 'package:flutter/material.dart';
import 'package:my_app/widgets/my_app_bar.dart';
import 'package:my_app/widgets/my_text.dart';
import 'package:my_app/widgets/my_text_field.dart';
import 'package:my_app/widgets/round_button.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
        title: 'Reset Password',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              height: size.height / 1.434,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height / 22,),  //height = 35.1
                        //old password
                        const MyText(text: 'Old Password'),
                        MyTextFormField(
                            controller: oldPasswordController,
                            hintText: '*****',
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400,)
                        ),

                        //New password
                        const MyText(text: 'New Password'),
                        MyTextFormField(
                            controller: newPasswordController,
                            hintText: '**********',
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400,)
                        ),

                        //Confirm Password
                        const MyText(text: 'Confirm Password'),
                        MyTextFormField(
                            controller: confirmPasswordController,
                            hintText: '**********',
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400,)
                        ),
                      ],
                    ),

                    //Button
                    const SizedBox(height: 65,),
                    RoundButton(title: 'Reset', onTap: (){}),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
