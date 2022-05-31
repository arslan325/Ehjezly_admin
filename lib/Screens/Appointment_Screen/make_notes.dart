import 'package:ehjezly_admin/Controllers/notification_controller.dart';
import 'package:ehjezly_admin/Models/appointment_model.dart';
import 'package:ehjezly_admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';
import '../../widgets/loading_widget.dart';

class MakeNotesForPatient extends StatefulWidget {
  final AppointmentModel appointmentModel;
  const MakeNotesForPatient({required this.appointmentModel,Key? key}) : super(key: key);

  @override
  State<MakeNotesForPatient> createState() => _MakeNotesForPatientState();
}

class _MakeNotesForPatientState extends State<MakeNotesForPatient> {
  final TextEditingController _notesTextEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
   _notesTextEditController.text = widget.appointmentModel.notes ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: kButtonColor,
          ),
          onPressed: () {
            // imagePickerController.disposeImage();
            Get.back();
          },
        ),
        title: Text(
            "Make Notes",
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: kButtonColor
            )
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Text(
                  "Make a short note or precaution for patients to prevent him/her from this disease.",
                  style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  )),
              const SizedBox(height: 30,),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                      TextFormField(
                      controller: _notesTextEditController,
                      maxLength: 500,
                      maxLines: 10,
                      //minLines: 1,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Please enter notes for patient';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Short Notes",
                        contentPadding: const EdgeInsets.symmetric(vertical: 17,horizontal: 10),
                        hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kLightTextColor
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusColor: kButtonColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kButtonColor, width: 1.0),
                          borderRadius: BorderRadius.circular(8),
                        ),

                      ),
                    ),
                      ],
                    )
                ),
              const SizedBox(height: 30,),
              CustomButton(title: "Save",
                  clickFuction: (){
                if(_formKey.currentState!.validate()){
                  loadingDialogue(context: context, message: 'Adding notes for patients');
                  appointmentController.updateAppointmentData(
                      {
                        "Notes" : _notesTextEditController.text,
                      },
                      widget.appointmentModel.appointmentId??"", context).then((value) {
                    adminController.getUserToken(widget.appointmentModel.patientId!).then((value) {
                      String title = "Notes Updated";
                      String message = 'Doctor update the notes for your treatment "${'${widget.appointmentModel.treatment}'}" and add some precaution. please check it on portal.';
                      adminController.sendNotification(title, message, value!);
                      NotificationController().addNotification(title, message,widget.appointmentModel.patientId!, context);
                    });
                        Navigator.pop(context);
                        _notesTextEditController.clear();
                  });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
