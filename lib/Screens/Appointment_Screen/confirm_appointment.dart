import 'package:ehjezly_admin/Screens/Appointment_Screen/make_notes.dart';

import '/Models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_button.dart';

class ConfirmAppointments extends StatefulWidget {
  const ConfirmAppointments({Key? key}) : super(key: key);

  @override
  State<ConfirmAppointments> createState() => _ConfirmAppointmentsState();
}

class _ConfirmAppointmentsState extends State<ConfirmAppointments> {

  Widget showStatusText(String status){
    if(status == "confirmed"){
      return Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.green,
        ),
      );
    }
    else if(status == "done"){
      return Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.green,
        ),
      );
    }
    else {
      return Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            //const SizedBox(height: 20,),
            Obx(() => (appointmentController.confirmAppointment.isNotEmpty)?
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appointmentController.confirmAppointment.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Appointment # " + index.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: kButtonColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Get.to(() => MakeNotesForPatient(appointmentModel: appointmentController.confirmAppointment[index],));
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: kButtonColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: const Icon(Icons.edit,
                                      color: Colors.white,
                                    )
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Patient Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(appointmentController.confirmAppointment[index].patientName!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(appointmentController.confirmAppointment[index].patientEmail!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                DateFormat('yyyy-MMMM-dd').format(appointmentController.confirmAppointment[index].appointmentDate!),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Time",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              //DateFormat('jm').format(time!)
                              Text(
                                DateFormat('jm').format(appointmentController.confirmAppointment[index].appointmentDate!),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Doctor Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                appointmentController.confirmAppointment[index].doctorName!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Treatment",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                appointmentController.confirmAppointment[index].treatment!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Status",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              showStatusText(appointmentController.confirmAppointment[index].status!)
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

                }):
            SizedBox(
              height: 200,
              child: Center(
                  child: Text('Confirm Appointment data is empty.',
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                      )
                  )),
            ),
            ),
          ],
        )
    );
  }
}
