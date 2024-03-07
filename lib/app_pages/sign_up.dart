import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/app_pages/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/utilities/utils.dart';
import 'package:my_app/widgets/my_app_bar.dart';
import 'package:my_app/widgets/my_text.dart';
import 'package:my_app/widgets/my_text_field.dart';
import 'package:my_app/widgets/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:my_app/widgets/select_image.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final fullNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  File? _image;
  final picker = ImagePicker();
  String? selectedImageName; // Variable to store the selected file name

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color(0xff07aeaf),
        appBar: const MyAppBar(title: 'Sign Up'),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: size.height / 1.1741,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                    ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Logo + All info of user collected here
                      Column(
                        children: [
                          //Logo
                          const Center(
                            child: Text(
                              'Logo',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                            ),
                          ),

                          //All Info collected here,
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //First name textfield
                                const MyText(text: 'Name'),
                                MyTextFormField(
                                  controller: fullNameController,
                                  hintText: 'Full Name',
                                  keyboardType: TextInputType.text,
                                ),

                                // Photo Addition field
                                const MyText(text: 'Add Image'),
                                const SelectImage(),

                                //Phone Number
                                const MyText(text: 'Contact Number'),
                                MyTextFormField(
                                  controller: contactNumberController,
                                  hintText: '03001234567',
                                  keyboardType: TextInputType.number,
                                ),

                                const MyText(text: 'Email'),
                                MyTextFormField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
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
                                  suffixIcon: Icon(Icons.visibility, color: Colors.grey.shade500,),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //Button
                      SizedBox(
                        height: size.height / 13,  //height is 40
                      ),
                      RoundButton(
                          title: 'Sign Up',
                          loading: loading,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              signUp();
                            }
                            // clearText();
                          }),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(() => const SignIn());
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 16),
                              ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) async {
      String imageUrl = '';
      if (_image != null) {
        imageUrl = await uploadImage();
      }
      ;
      String uid = _auth.currentUser!.uid;
      StoreOnFireStore().addUser(
          fullName: fullNameController.text,
          imageUrl: imageUrl,
          contactNumber: contactNumberController.text,
          email: emailController.text,
          password: passwordController.text,
          status: false,
          uid: uid);
      Utils().toastMessage('SignUp Successfully');
      Get.to(() => const SignIn());
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  void clearText() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        selectedImageName = pickedFile.name;
      } else {
        print('no image picked');
      }
    });
  }

  Future uploadImage() async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('/usersImages/${DateTime.now().millisecondsSinceEpoch}');
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

      final snapShot = await uploadTask;
      final downloadUrl = await snapShot.ref.getDownloadURL();

      //Utils().toastMessage('Image Uploaded Successfully');
      return downloadUrl;
    } catch (e) {
      Utils().toastMessage('Image Upload Failed: $e');
      return 'Image Upload Failed: $e';
    }
  }
}

class StoreOnFireStore {
  Future<String?> addUser(
      {required String fullName,
      required String imageUrl,
      required String contactNumber,
      required String email,
      required String password,
      required bool status,
      required String uid}) async {
    try {
      CollectionReference user = FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user
      await user.doc(email).set({
        'Full Name': fullName,
        'Users Image': imageUrl,
        'Contact Number': contactNumber,
        'Email': email,
        'Password': password,
        'Status': status,
        'Uid': uid
      }).catchError((e) {
        //print('Error adding user$e');
        return e;
      });
      //print('Error adding user');
      return 'success';
    } catch (e) {
      //print('Error adding user$e');
      return 'Error adding user$e';
    }
  }

  Future<List<Map<String, dynamic>>> getUser() async {
    List<Map<String, dynamic>> usersDetails = [];
    try {
      CollectionReference user = FirebaseFirestore.instance.collection('users');
      final snapShot = await user.get();

      for (var doc in snapShot.docs) {
        usersDetails.add(doc.data() as Map<String, dynamic>);
      }
      return usersDetails;
    } catch (e) {
      print('Error fetching names: $e');
      return [];
    }
  }

// Future<List<String>> getUser() async {
//   try {
//     CollectionReference user = FirebaseFirestore.instance.collection('users');
//     final querySnapshot = await user.get();
//     List<String> names = [];
//     querySnapshot.docs.forEach((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       names.add(data['Full Name']);
//     });
//     return names;
//   } catch (e) {
//     print('Error fetching names: $e');
//     return [];
//   }
// }
}
