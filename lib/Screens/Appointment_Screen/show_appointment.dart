import 'package:ehjezly_admin/Screens/Appointment_Screen/pending_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';
import 'confirm_appointment.dart';
import 'done_appointments.dart';

class ShowAllAppointments extends StatefulWidget {
  final int index;
  const ShowAllAppointments({required this.index,Key? key}) : super(key: key);

  @override
  State<ShowAllAppointments> createState() => _ShowAllAppointmentsState();
}

class _ShowAllAppointmentsState extends State<ShowAllAppointments> {
  List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Pending',
      icon: Icon(Icons.pending_actions),
    ),
    const Tab(
      text: 'Confirmed',
      icon: Icon(Icons.confirmation_num_outlined),
    ),
    const Tab(
      text: "Done",
      icon: Icon(Icons.done),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.index,
      length: myTabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: AppBar(
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs:myTabs,
              labelColor: Colors.black,
              indicatorColor: kButtonColor,
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: kButtonColor,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  backgroundColor: kLightGreyColor,
                  backgroundImage: adminController.adminData.value.profile != null?NetworkImage(adminController.adminData.value.profile!):null,
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: adminController.adminData.value.profile == null?const Image(
                      image: AssetImage('images/avatar.png'),
                      fit: BoxFit.cover,
                    ):null,
                  ),
                ),
              ),
            ],
            title: Text("Appointments",style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kButtonColor
            ),),
          ),
        ),
        body: const TabBarView(
          children: [
            PendingAppointment(),
            ConfirmAppointments(),
            DoneAppointment(),
          ],
        ),
      ),
    );
  }
}
