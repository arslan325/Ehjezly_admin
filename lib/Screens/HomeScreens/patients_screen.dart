import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
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
            "Update Doctor",
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: kButtonColor
            )
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(()=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: (
               ListView.builder(
                  itemCount: patientController.patients.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        elevation: 5,
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: patientController.patients[index].profile != null ?NetworkImage(patientController.patients[index].profile!):null,
                              child: ClipOval(
                                  child: patientController.patients[index].profile == null ?const Image(
                                    image: AssetImage('images/avatar.png'),
                                    fit: BoxFit.cover,
                                  ):Container()),
                            ),
                            title: Text(
                                patientController.patients[index].name ??"Patient Name",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                )
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
          )
          )
        ],
      ),
    );
  }
}
