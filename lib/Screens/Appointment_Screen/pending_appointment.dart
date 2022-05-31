import 'package:ehjezly_admin/Controllers/notification_controller.dart';

import '../../widgets/custom_dialogue.dart';
import '/Models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../Constant/constant.dart';
import '../../../widgets/custom_button.dart';

class PendingAppointment extends StatefulWidget {
  const PendingAppointment({Key? key}) : super(key: key);

  @override
  State<PendingAppointment> createState() => _PendingAppointmentState();
}

class _PendingAppointmentState extends State<PendingAppointment> {

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
      backgroundColor: kBackgroundColor,
        body: ListView(
          children: [
            //const SizedBox(height: 20,),
            Obx(() => (appointmentController.pendingAppointment.isNotEmpty)?
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appointmentController.pendingAppointment.length,
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
                                  confirmationDialogue(title: "Confirmation",
                                      bodyText: "Are you sure you want to delete the details of appointment?",
                                      function: (){
                                        appointmentController.deleteAppointment(appointmentController.pendingAppointment[index].appointmentId??"", context).catchError((e){
                                          Navigator.pop(context);
                                          customDialogue(
                                              title: "Something went wrong",
                                              bodyText: e.message.toString(),
                                              context: context
                                          );
                                        });
                                      },
                                      context: context
                                  );
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: const Icon(Icons.delete,
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
                              Text(appointmentController.pendingAppointment[index].patientName!,
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
                                  child: Text(appointmentController.pendingAppointment[index].patientEmail!,
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
                                DateFormat('yyyy-MMMM-dd').format(appointmentController.pendingAppointment[index].appointmentDate!),
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
                                DateFormat('jm').format(appointmentController.pendingAppointment[index].appointmentDate!),
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
                                appointmentController.pendingAppointment[index].doctorName!,
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
                                appointmentController.pendingAppointment[index].treatment!,
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
                              showStatusText(appointmentController.pendingAppointment[index].status!)
                            ],
                          ),
                          appointmentController.pendingAppointment[index].status == "pending"? Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: CustomButton(title: "Confirm", clickFuction: (){
                              String id = appointmentController.pendingAppointment[index].patientId!;
                              String treatment = appointmentController.pendingAppointment[index].treatment!;

                              appointmentController.updateAppointmentData(
                                  {
                                    AppointmentModel.appointmentSTATUS : "confirmed"
                                  },
                                  appointmentController.pendingAppointment[index].appointmentId!, context).then((value) {
                                adminController.getUserToken(id).then((value) {
                                  print(value);
                                  String title = "Appointment Confirmed";
                                  String message = 'You booked an appointment for "$treatment" is confirmed now. please check your appointment detail on portal.';
                                  adminController.sendNotification(title,message,value!);
                                  NotificationController().addNotification(title, message,id, context);
                                });
                              });
                            }),
                          ):Container(),
                        ],
                      ),
                    ),
                  );

                }):
            SizedBox(
              height: 200,
              child: Center(
                  child: Text('Pending Appointment data is empty.',
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
