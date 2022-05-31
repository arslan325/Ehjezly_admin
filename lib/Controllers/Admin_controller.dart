
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ehjezly_admin/Constant/constant.dart';
import 'package:ehjezly_admin/Models/admin_model.dart';
import 'package:ehjezly_admin/Screens/home_screen.dart';
import '../Screens/welcome_screen.dart';
import '../managers/preference_manager.dart';
import '/widgets/custom_dialogue.dart';
import '/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AdminController extends GetxController{
  static AdminController instance = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  Rx<AdminModel> adminData = AdminModel().obs;
  User? currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference adminReference =
  FirebaseFirestore.instance.collection('Admin');
  CollectionReference userReference =
  FirebaseFirestore.instance.collection('users');

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //binding all Streams
    currentUser = user;
    if (currentUser != null) {
     doctorController.bindingStream();
       appointmentController.bindingStream();
     patientController.bindingStream();
      // cartController.bindingStream();
      adminData.bindStream(listenToUser());
    }

  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future<void> updateFCMDeviceToken() async{
    var token = await firebaseMessaging.getToken();
    await adminReference.doc(currentUser?.uid).update({
      'Token':token,
    });
    firebaseMessaging.subscribeToTopic('allUsers');
  }

  Stream<AdminModel> listenToUser() =>
      adminReference.doc(firebaseUser.value?.uid).snapshots()
          .map((snapshot) => AdminModel.fromMap(snapshot.data() as Map<String, dynamic>));



  Future<void> logIn(
      String email, password, context) async {
    loadingDialogue(context: context , message: "Login process started");
    // await sharedPreferences!.clear();
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((auth) async{
      currentUser = auth.user;
      final dataSnapshot = await adminReference
          .doc(currentUser!.uid)
          .get();
      if(dataSnapshot.exists){
        if(currentUser != null){
          updateFCMDeviceToken();
          PreferenceManager().setEmail = currentUser?.email ?? "email@gmail.com";
          PreferenceManager().setName = dataSnapshot["name"];
          Navigator.pop(context);
          Get.offAll(const HomeScreen());
        }
      }
      else{
        Navigator.pop(context);
        firebaseAuth.signOut();
        Get.snackbar(
          "Something went wrong",
          "There is no user record corresponding to this identifier. The user may have been deleted.",
          backgroundColor: const Color(0x85ffffff),
        );
      }
      }).catchError((onError) {
        Navigator.pop(context);
        Get.snackbar(
          "Something went wrong",
          onError.message.toString(),
          backgroundColor: const Color(0x85ffffff),
        );
      });
  }

  String? token;
  Future<String?> getUserToken(String id) async{
    await userReference.doc(id)
        .get().then((value) {
      token = value["Token"];
    });
    return token;
  }


  Future<void> updateAdminData(String url,context) async{
    await adminReference.doc(currentUser?.uid).update({
      'profile':url,
    }
    ).then((value) {
      PreferenceManager().setProfile = url;
      Get.snackbar(
        "Successfully",
        "Details of user updated successfully",
        backgroundColor: const Color(0x85ffffff),
      );
    }
    ).catchError((e){
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }

  Future<void> resetPassword(String email, context) async {
    loadingDialogue(context: context , message: "Sending email");
    await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.pop(context);
      customDialogue(context:context,title: "Check your email",bodyText: "We have sent a password recover instructions to your email",);
    }).catchError((error) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        error.message.toString(),
        backgroundColor: const Color(0x85ffffff),
      );
    });
  }

  void  signOut ()async{
    await firebaseAuth.signOut();
    Get.offAll(const WelcomeScreen());
  }
  Future<void> sendNotification(String notificationTitle, String notificationBody, String targetFCMToken) async {
    const String _url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> _headers = <String, String>{};
    _headers['Content-Type'] = 'application/json';
    _headers['Authorization'] = 'key=AAAAZgaK2Vw:APA91bGjE-ptI0bDOagsa6pDnEO23t8XhdPlYZE-Uf9USo_AFo57GhrnWtMeHy5tBMAGJpy7R9haLe5dHFMkmChmAl2VnifXuvTSV_XkQ1wJBSiGzGzOXOoIiwG7LKkethXBWHid18Ph';

    Map<String, dynamic> _body = Map<String, dynamic>();
    _body['notification'] = {
      'title': notificationTitle,
      'body': notificationBody,
      //'image': imageUrl,
      'sound': 'default'
    };
    _body['priority'] = 'high';
    _body['data'] = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done'
    };
    _body['to'] = targetFCMToken;
    await http.post(Uri.parse(_url), headers: _headers, body: jsonEncode(_body),);

  }

}