import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app_pages/sign_up.dart';
import 'package:my_app/app_pages/splash_screen.dart';
import 'package:my_app/controllers/sign_in_controller.dart';
import 'package:my_app/navbar_page.dart';
import 'package:my_app/user_side_pages.dart';
import 'package:get/get.dart';
import 'package:my_app/utilities/utils.dart';
import 'package:my_app/widgets/my_app_bar.dart';
import 'package:my_app/widgets/my_text.dart';
import 'package:my_app/widgets/my_text_field.dart';
import 'package:my_app/widgets/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  static const String id = 'sign_in';

  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final SignInController controller = Get.put(SignInController());

  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff07aeaf),
      appBar: const MyAppBar(title: 'Sign In'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60),
            child: Container(
              height: size.height / 1.23,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Center(
                            child: Text('Logo',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 34)),
                          ),
                        ),
                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 50),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _twoButtons(context, button: 0, label: 'Admin'),
                                _twoButtons(context, button: 1, label: 'Employee'),
                              ],
                            ),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Email & Password Section start here
                                const MyText(text: 'Enter Email'),
                                MyTextFormField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    color: Colors.grey.shade500,
                                  ),
                                ),

                                const MyText(text: 'Password'),
                                MyTextFormField(
                                  controller: passwordController,
                                  hintText: 'password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.grey.shade500,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.visibility,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),


                    SizedBox(
                      height: size.height / 6.7, //height is 115.2
                    ),
                    RoundButton(
                        title: 'Sign In',
                        loading: loading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                          clearText();
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(() => const SignUp());
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 16),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //Login ka Function bnaya h
  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    )
        .then((value) async {
      Utils().toastMessage(value.user!.email.toString());
      //if Successfully loggedIn (credentials aare correct)
      final currentUserUid = FirebaseAuth.instance.currentUser?.email;
      updateUserStatusToOnline(currentUserUid!);
      var sharedPreference = await SharedPreferences.getInstance();
      sharedPreference.setBool(SplashScreenState.keyLogin, true);
      sharedPreference.setBool(SplashScreenState.isAdmin,
          controller.currentButton.value == 0 ? true : false);

      Get.to(() => controller.currentButton.value == 0
          ? const NavBarPage()
          : const UserSidePages());

      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  //TextField s text ko clear krny k liy y Function bnaya h
  void clearText() {
    emailController.clear();
    passwordController.clear();
  }

  // Function to update the user's status to "online"
  Future<void> updateUserStatusToOnline(String email) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    await usersCollection.doc(email).update({
      'Status': true,
    });
  }

  Widget _twoButtons(BuildContext context, {required button, required label}) {
    return InkWell(
      onTap: () {
        //Get.to( () => button == 0 ? const NavBarPage() : const UserSidePages() );
        controller.goToButton(button);
      },
      child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: controller.currentButton.value == button
                ? const Color(0xff07aeaf)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: controller.currentButton.value == button
                      ? Colors.white
                      : Colors.black,
                  fontSize: 17),
            ),
          )),
    );
  }
}
