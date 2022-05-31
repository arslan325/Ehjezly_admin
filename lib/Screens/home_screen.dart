

import 'package:ehjezly_admin/Screens/Appointment_Screen/done_appointments.dart';
import 'package:ehjezly_admin/Screens/Appointment_Screen/show_appointment.dart';
import 'package:ehjezly_admin/Screens/HomeScreens/show_doctors.dart';
import 'package:get/get.dart';

import '../widgets/admin_drawer.dart';
import '../widgets/custom_carousel.dart';
import '../widgets/custom_dialogue.dart';
import '/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomeScreens/patients_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: Text("Admin",style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: kButtonColor
        ),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu,color: kButtonColor,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: kButtonColor,),
            onPressed: () {
              confirmationDialogue(title: "Confirmation",
                  bodyText: "Are you sure you want to logout?",
                  function: (){
                    adminController.signOut();
                  },
                  context: context
              );
            },
          ),
        ],
      ),
      drawer: const AdminDrawer(),
      body: Obx(()=>(
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40,),
              InkWell(
                onTap: () {
                 Get.to(() => const PatientScreen());
                },
                child: SizedBox(
                    height: 170,
                    child: Card(
                      color: kButtonColor,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        patientController.patients.length.toString(),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Total Patients',
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  )),
                              const Expanded(
                                child: Icon(
                                  Icons.supervised_user_circle,
                                  size: 120,
                                  color: Colors.white12,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                color: Colors.black.withOpacity(0.4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View more info',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const CircleAvatar(
                                      radius: 13,
                                      backgroundColor: kButtonColor,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                 Get.to(() => const ShowDoctors());
                },
                child: SizedBox(
                    height: 170,
                    child: Card(
                      color: Colors.deepOrangeAccent,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        doctorController.doctors.length.toString(),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Total Doctors',
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  )),
                              const Expanded(
                                child: Icon(
                                  Icons.supervised_user_circle,
                                  size: 120,
                                  color: Colors.white12,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                color: Colors.black.withOpacity(0.4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View more info',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Colors.deepOrangeAccent,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const ShowAllAppointments(index: 2,));
                },
                child: SizedBox(
                    height: 170,
                    child: Card(
                      color: Colors.amberAccent,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        appointmentController.doneAppointment.length.toString(),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Total Appointment',
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  )),
                              const Expanded(
                                child: Icon(
                                  Icons.supervised_user_circle,
                                  size: 120,
                                  color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                color: Colors.black.withOpacity(0.4),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View more info',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const CircleAvatar(
                                      radius: 13,
                                      backgroundColor: Colors.amberAccent,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ))
    );
  }
}

