import 'package:ehjezly_admin/Controllers/doctor_controller.dart';
import 'package:ehjezly_admin/Controllers/patient_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Controllers/appointment_controller.dart';
import '../Controllers/image_controller.dart';
import '/Controllers/Admin_controller.dart';
import 'package:flutter/material.dart';


const  kBackgroundColor = Colors.white;
const kButtonColor = Color(0xff432c81);
const kLightTextColor = Color(0xff7b6ba8);
const kButtonTextColor = Colors.white;
const kLightGreyColor = Color(0xffedecf5);
const kLightGrey2Color = Color(0xfff4f5f6);




AdminController adminController = AdminController.instance;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;


ImagePickerController imagePickerController = ImagePickerController.instance;
DoctorController doctorController = DoctorController.instance;
AppointmentController appointmentController = AppointmentController.instance;
PatientController patientController = PatientController.instance;
