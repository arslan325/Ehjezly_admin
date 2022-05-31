import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_dialogue.dart';
class NotificationController {


  CollectionReference notificationReference = FirebaseFirestore.instance.collection('Notification');



  //1:
  Future<void> addNotification(String title , String message,String id ,context) async{
    String docId = notificationReference.doc().id;
    await notificationReference.doc(docId).set({
      'Uid' : docId,
      'User Id':id,
      'Title' : title,
      'Message' : message,
      "Notification On": DateTime.now(),
    }
    ).catchError((e){
      Navigator.pop(context);
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }


}