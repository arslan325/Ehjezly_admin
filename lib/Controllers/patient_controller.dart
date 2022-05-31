
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/patient_model.dart';
import '/widgets/custom_dialogue.dart';
import '../Constant/constant.dart';
import '../Screens/home_screen.dart';
import '../Screens/welcome_screen.dart';
import '/Screens/login_screen.dart';
import '/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientController extends GetxController{
  static PatientController instance = Get.find();

  CollectionReference userReference =
  FirebaseFirestore.instance.collection('users');

  RxList<PatientModel> patients = RxList<PatientModel>([]);

  @override
  onReady() {
    super.onReady();
    bindingStream();
  }
  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      patients.bindStream(listenToPatients());
    }
  }



  Stream<List<PatientModel>> listenToPatients() =>
      userReference.snapshots().map((query) =>
          query.docs.map((item) => PatientModel.fromMap(item.data() as Map<String, dynamic>)).toList());


}