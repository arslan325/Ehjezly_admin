import 'package:cloud_firestore/cloud_firestore.dart';
import '/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/doctor_model.dart';
import '../widgets/custom_dialogue.dart';
import '../widgets/loading_widget.dart';
import '../Models/appointment_model.dart';

class AppointmentController extends GetxController{
  static AppointmentController instance = Get.find();
  CollectionReference appointmentReference = FirebaseFirestore.instance.collection('Appointment');
  RxList<AppointmentModel> pendingAppointment = RxList<AppointmentModel>([]);
  RxList<AppointmentModel> confirmAppointment = RxList<AppointmentModel>([]);
  RxList<AppointmentModel> doneAppointment = RxList<AppointmentModel>([]);

  @override
  onReady() {
    super.onReady();
    bindingStream();
  }

  bindingStream() {
    if (firebaseAuth.currentUser != null) {
      pendingAppointment.bindStream(getPendingAppointment("pending"));
      confirmAppointment.bindStream(getPendingAppointment("confirmed"));
      doneAppointment.bindStream(getPendingAppointment("done"));
    }
  }


  Stream<List<AppointmentModel>> getPendingAppointment(String status) => appointmentReference
      .where("Status", isEqualTo: status)
      .orderBy("Publish Date", descending: true)
      .snapshots()
      .map((query) => query.docs
      .map((item) =>
      AppointmentModel.fromMap(item.data() as Map<String, dynamic>))
      .toList());





  Future<void> updateAppointmentData(Map<String, dynamic> data,String id , context) async{
    await appointmentReference.doc(id).update(
        data
    ).then((value) {
      Get.snackbar(
        "Successfully",
        "Details of appointment updated successfully",
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

  Future<void> deleteAppointment(String uid,context) async{
    await appointmentReference.doc(uid).delete().then((value) {
      Get.snackbar(
        "Successfully",
        "Details of appointment delete successfully",
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