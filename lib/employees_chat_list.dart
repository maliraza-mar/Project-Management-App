import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app_pages/chat_screen.dart';
import 'package:my_app/app_pages/sign_up.dart';


class EmployeesChatList extends StatefulWidget {
  const EmployeesChatList({super.key});

  @override
  State<EmployeesChatList> createState() => _EmployeesChatListState();
}

class _EmployeesChatListState extends State<EmployeesChatList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List allUsersDetails = [];

  @override
  void initState() {
    getUserDetails();
    super.initState();
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
            color: Colors.white,
          ),
          iconSize: 18,
        ),
        title: const Text('Chats', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff07aeaf),
        elevation: 0,
      ),

      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: _firestore.collection('users').snapshots(),
                  builder: (context, snapShot) {
                    if(snapShot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading') ;
                    }
                    if(snapShot.hasError){
                      return const Text('No Employee available') ;
                    }
                    return ListView.builder(
                      itemCount: snapShot.data!.docs.length,
                      itemBuilder: (context, index) {
                          return _buildUserListItem(snapShot.data!.docs[index]) ;
                      });
                  }
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //build Individual user list item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic> ;
    final currentUser = _auth.currentUser?.email;

    // display all users except current user
    if(_auth.currentUser!.email != data['Email']){
      return Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.only(left: 7, right: 7),
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(data['Users Image'])
            ),
            title: Text(data['Full Name']),
            trailing: const Text('2:30 PM'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    receiverUserEmail: data['Email'],
                      receiverUserId: data['Uid'],
                      usersData: getChatUser(data['Email']),
                  )
              ));
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void getUserDetails() async{
    try{
      List<Map<String, dynamic>> user = await StoreOnFireStore().getUser();
      setState(() {
        allUsersDetails = user;
      });
    } catch(e){
      print('Error fetching details : $e');
    }
  }

  Map<String, dynamic> getChatUser(String UsersData){
    for(var userData in allUsersDetails){
      if(userData['Email'] == UsersData){
        return userData;
      }
    }
    return {};
  }

}
