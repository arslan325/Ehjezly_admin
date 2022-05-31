import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Models/doctor_model.dart';
import '../widgets/custom_dialogue.dart';
class DoctorController extends GetxController {
  static DoctorController instance = Get.find();
  CollectionReference doctorReference = FirebaseFirestore.instance.collection('Doctors');
  RxList<DoctorModel> doctors = RxList<DoctorModel>([]);

  @override
  onReady() {
    super.onReady();
    bindingStream();
  }
  bindingStream() {
    if (FirebaseAuth.instance.currentUser != null) {
      doctors.bindStream(getAllDoctors());
    }
  }
  Stream<List<DoctorModel>> getAllDoctors() =>
      doctorReference.orderBy('Publish Date', descending: true).snapshots().map((query) =>
          query.docs.map((item) => DoctorModel.fromMap(item.data() as Map<String, dynamic>)).toList());


  //1:
  Future<void> addDoctor(String name , String imageUrl ,List dateTime ,List<String> treatment ,List time,context) async{
    String docId = doctorReference.doc().id;
    await doctorReference.doc(docId).set({
      'Doctor Id' : docId,
      'Doctor Name' : name,
      'Image Url' : imageUrl,
      "Unavailable Dates": dateTime,
      'Publish Date' : DateTime.now(),
      "Treatment":treatment,
      "Unavailable Time":time
    }).then((value) {
      Get.snackbar(
        "Successfully",
        "Details of doctor added successfully",
        backgroundColor: const Color(0x85ffffff),
      );
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
  Future<void> updateDoctor(DoctorModel doctorModel,context) async{
    await doctorReference.doc(doctorModel.docId).update(
      doctorModel.toJson()
    ).then((value) {
      Get.snackbar(
        "Successfully",
        "Details of doctor updated successfully",
        backgroundColor: const Color(0x85ffffff),
      );
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

  Future<void> deleteDoctor(String uid,context) async{
    await doctorReference.doc(uid).delete().then((value) {
      Get.snackbar(
        "Successfully",
        "Details of doctor delete successfully",
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


}