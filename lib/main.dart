import 'package:ehjezly_admin/Constant/constant.dart';
import 'package:ehjezly_admin/Controllers/doctor_controller.dart';
import 'package:ehjezly_admin/Controllers/image_controller.dart';
import 'package:ehjezly_admin/Controllers/patient_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'Controllers/Admin_controller.dart';
import 'Controllers/appointment_controller.dart';
import 'Screens/home_screen.dart';
import 'Screens/welcome_screen.dart';
import 'managers/preference_manager.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceManager().init();
  await Firebase.initializeApp().then((value){
    Get.put(AdminController());
    Get.put(ImagePickerController());
    Get.put(DoctorController());
    Get.put(AppointmentController());
    Get.put(PatientController());
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: kButtonColor
      ),
      home: FirebaseAuth.instance.currentUser ==null? const WelcomeScreen() :const HomeScreen(),
    );
  }
}

