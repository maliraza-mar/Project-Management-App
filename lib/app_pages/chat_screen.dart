import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_app/services/chat_services.dart';
import 'package:my_app/shared_database/local_database.dart';


class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  final Map<String, dynamic> usersData;
  const ChatScreen({super.key, required this.receiverUserId ,required this.usersData, required this.receiverUserEmail});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //NotificationServices notificationServices = NotificationServices();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ChatService _chatService = ChatService();
  final LocalDatabase _localDatabase = LocalDatabase();
  List<Map<String, dynamic>> firestoreMessages = [ ] ;
  bool? hasInternet;

  @override
  void initState() {
    super.initState();
    _localDatabase.initPreference();
    print('ChatRoomId is : ${widget.receiverUserId}');
    //print('usersStatus : ${widget.usersData['Status']}');
    //updateStatus();
    //fetch firestoreMessages and store them in firestoreMessages List
    _chatService.getMessages(widget.receiverUserId, _auth.currentUser!.uid).listen((snapshot) {
      try{
        if(snapshot.docs.isNotEmpty){
          firestoreMessages = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        }
        setState(() {});
      } catch(e){
        print('Error fetching messages : $e');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
                size: 20,
              )),
        ),
        leadingWidth: 30,

        title: Row(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: widget.usersData.isNotEmpty && widget.usersData['Users Image'] != 'N/A'
                    ? NetworkImage(widget.usersData['Users Image'])
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                widget.usersData.isNotEmpty ? widget.usersData['Full Name'] : 'N/A',
                style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.call,
              color: Colors.black,
            ),
          )
        ],
        //centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.2,
      ),

      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),

          Expanded(
              child: StreamBuilder(
                stream: _localDatabase.localMessagesStream ,
                builder: (context, localsnapshot){
                  if(localsnapshot.hasError){
                    print('Error: ${localsnapshot.error}');
                    return Text('Error: ${localsnapshot.error}');
                  }
                  print('Saved Chat is : ${localsnapshot.hasData}');
                  final localMessages = localsnapshot.data ?? [] ;
                  final localMessagesMap = localMessages.map((msg) => msg.toMap()).toList();
                  print('LocalMessagesMap: $localMessagesMap'); // Debug line

                  // Filter out messages that are already in firestoreMessages
                  final uniqueLocalMessages = localMessagesMap
                      .where((localMsg) => !firestoreMessages.any(
                          (firestoreMsg) => firestoreMsg['messageId'] == localMsg['messageId']))
                      .toList();
                  final allMessages = firestoreMessages + uniqueLocalMessages;
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: allMessages.length,
                    itemBuilder: (context, index){
                      final messages = allMessages[index] ;
                      return _buildMessageItem(messages) ;
                    }
                  );
                }
              )
          ),

          const SizedBox(
            height: 91,
          ),
        ],
      ),

      //TextField Area of message and send icon
      bottomSheet: BottomAppBar(
        color: Colors.grey[50],
        height: MediaQuery.of(context).size.height / 10,
        child: Row(
          children: [
            PopupMenuButton(
                offset: const Offset(0, -230),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                color: Colors.white,
                icon: const Icon(
                  Icons.attach_file,
                  color: Colors.blueGrey,
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                      value: '1',
                      child: Column(
                        children: [
                          Icon(
                            Icons.file_copy,
                            color: Color(0xff07aeaf),
                          ),
                          Text(
                            'Document',
                            style: TextStyle(color: Color(0xff07aeaf)),
                          )
                        ],
                      )),
                  const PopupMenuItem(
                      value: '2',
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: Color(0xff07aeaf),
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(color: Color(0xff07aeaf)),
                          )
                        ],
                      )),
                  const PopupMenuItem(
                      value: '3',
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            color: Color(0xff07aeaf),
                          ),
                          Text(
                            'Contact',
                            style: TextStyle(color: Color(0xff07aeaf)),
                          )
                        ],
                      )),
                  const PopupMenuItem(
                      value: '4',
                      child: Column(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Color(0xff07aeaf),
                          ),
                          Text(
                            'Location',
                            style: TextStyle(color: Color(0xff07aeaf)),
                          )
                        ],
                      )),
                ]
            ),

            Expanded(
              child: TextField(
                controller: _messageController,
                minLines: 1,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Type a message',
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 5, left: 5),
              child: CircleAvatar(
                backgroundColor: const Color(0xff07aeaf),
                child: IconButton(
                  onPressed: sendMessage,
                    //await onSendMessage();
                  iconSize: 28,
                  padding: const EdgeInsets.only(bottom: 0, left: 3),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    //Map<String, dynamic> data = document.data() as Map<String, dynamic> ;
    var alignment = data['senderId'] == _auth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft ;
    final dynamic timestamp= data['timestamp'];  // get firestore timestamp
    final DateTime sendTime = timestamp is Timestamp
        ? timestamp.toDate()
        : (timestamp is String
          ? DateTime.parse(timestamp)
          : DateTime.now());
    Icon statusIcon;
    //MsgStatus messageStatus = MsgStatus.sent;
    // if (data['status'] == 'sent') {
    //   statusIcon = const Icon(Icons.done, color: Colors.white, size: 14);
    // } else if (data['status'] == 'delivered') {
    //   statusIcon = const Icon(Icons.done_all, color: Colors.white, size: 14);
    // } else if (data['status'] == 'seen') {
    //   statusIcon = const Icon(Icons.done_all, color: Colors.yellow, size: 14);
    // } else {
    //   statusIcon = const Icon(Icons.access_time, color: Colors.white, size: 14);
    // }

    if (data['isSeen'] == false) {
      statusIcon = const Icon(Icons.done, color: Colors.white, size: 15);
    } else {
      statusIcon = const Icon(Icons.done_all, color: Colors.white, size: 15);
    }



    return Container(
      margin: data['senderId'] == _auth.currentUser!.uid
         ? const EdgeInsets.fromLTRB(45, 0, 10, 7)
         : const EdgeInsets.fromLTRB(10, 0, 45, 7),
      alignment: alignment,
      constraints: BoxConstraints(        //The constraints property limits the maximum width to 70% of the screen width
         maxWidth: MediaQuery.of(context).size.width * .7,
        minWidth: MediaQuery.of(context).size.width / 7
      ),
      decoration: BoxDecoration(
        color: data['senderId'] == _auth.currentUser!.uid
            ? const Color(0xff07aeaf)
            : const Color(0xff677D81),
        borderRadius: data['senderId'] == _auth.currentUser!.uid
          ? const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
              bottomLeft: Radius.circular(6))
          : const BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
              bottomLeft: Radius.circular(6))
      ),
      child: Stack(
        children: [
          Padding(
            padding: data['senderId'] == _auth.currentUser!.uid
                ? const EdgeInsets.only( top: 8, left: 5, right: 14, bottom: 15)
                : const EdgeInsets.only( top: 8, left: 5, right: 4, bottom: 11),
            child: Text(data['message'],
              style: const TextStyle(fontSize: 17, color: Colors.white),),
          ),
          Positioned(
            bottom: 1,
            right: 2,
            child: Row(
              children: [
                data['senderId'] == _auth.currentUser!.uid
                    ? Text(DateFormat('hh:mm a').format(sendTime),
                  style: const TextStyle(color: Colors.white, fontSize: 9.5),)
                    : const Text(''),
                //_chatIcons(newMessage, hasInternet as bool, data['Status'])
                const SizedBox(width: 2.5,),
                data['senderId'] == _auth.currentUser!.uid
                    ? statusIcon
                    : Text(''),
              ],
            )
          ),
        ],
      ),
    );
  }

  void sendMessage() async{
    //only send message if there is something to send
    if(_messageController.text.isNotEmpty){
      final newMessage = await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);

      await _localDatabase.saveChatLocally([newMessage]);
      await updateMessageStatusToDelivered(widget.receiverUserId, _auth.currentUser!.uid);
      hasInternet = await checkInternetConnectivity();
    }
    //clear the message after sending
    _messageController.clear();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true; // Indicate that there is internet connectivity.
    }
    return false; // Indicate that there is no internet connectivity.
  }

  Future<void> updateMessageStatusToDelivered(String userId, String otherUserId) async {
    // Get the user's online status (you may need to replace this with your actual method to get the user's status)
    bool userOnline = widget.usersData['Status'];
    //print('userStatus is :$userOnline');

    // If the user is online, set the message status to "seen" for each unsent message
    if (userOnline) {
      List<String> ids = [userId, otherUserId];
      ids.sort();
      String chatRoomId = ids.join("_");

      for (final message in firestoreMessages) {
        if (message['isSeen'] == false) {
          final messageId = message['messageId'];
          await _firestore
              .collection('chat_room')
              .doc(chatRoomId)
              .collection('messages')
              .doc(messageId)
              .update({
            'isSeen': true,
          });
          print('Message $messageId marked as seen.');
        }
      }
    }
  }


  // Future<void> updateMessageStatusToDelivered(String userId, String otherUserId) async {
  //   // Custom logic based on your requirements
  //   for (final message in firestoreMessages) {
  //     if (message['isSeen'] == false) {
  //       if (widget.usersData['Status']) {
  //         // If the user is online, set isSeen to true
  //         List<String> ids = [userId, otherUserId];
  //         ids.sort();
  //         String chatRoomId = ids.join("_");
  //         final messageId = message['messageId'];
  //         await _firestore.collection('chat_room').doc(chatRoomId).collection('messages').doc(messageId).update({
  //           'isSeen': true,
  //         });
  //         print('Message $messageId marked as seen.');
  //       }
  //     }
  //   }
  // }

  // void updateStatus()async{
  //   await updateMessageStatusToDelivered(widget.receiverUserId, _auth.currentUser!.uid);
  //   print('usersStatus : ${widget.usersData['Status']}');
  // }


  // Future<void> noNetStatusNull(String currentUserId, String receiverId) async{
  //   for(final message in firestoreMessages) {
  //     List<String> ids = [currentUserId, receiverId];
  //     ids.sort();
  //     String chatRoomId = ids.join("_");
  //     final messageId = message['messageId'];
  //     await _firestore.collection('chat_room').doc(chatRoomId).collection('messages').doc(messageId).update({
  //       'status': '',
  //     });
  //   }
  // }
  // Check network connectivity and update message status when online
  // Future<void> checkAndHandleConnectivity() async {
  //   final connectivityResult = await checkConnectivity();
  //
  //   if (connectivityResult == ConnectivityResult.none) {
  //     // No internet connectivity, set message status to null
  //     // Handle this case based on your requirements.
  //   } else {
  //     // Internet connectivity is available, update message status to "delivered"
  //     await updateMessageStatusToDelivered();
  //   }
  // }


// void _updateMessagesToDelivered(userId, otherUserId) {
  //   List<String> ids = [userId, otherUserId];
  //   ids.sort();
  //   String chatRoomId = ids.join("_");
  //   final currentUserId = _auth.currentUser!.uid;
  //   final messagesRef = _firestore.collection('chat_room').doc(chatRoomId).collection('messages');
  //
  //   for (var message in firestoreMessages) {
  //     // Check if the message sender is the current user and the status is not 'seen'
  //     if (message['senderId'] == currentUserId && message['status'] != 'seen') {
  //       final messageId = message['messageId'];
  //       final messageRef = messagesRef.doc(messageId);
  //
  //       // Update the message status to 'delivered'
  //       messageRef.update({'status': 'delivered'}).then((_) {
  //         print('Message $messageId updated to "delivered"');
  //       }).catchError((error) {
  //         print('Error updating message status: $error');
  //       });
  //     }
  //   }
  // }


}


