import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';
import '../../widgets/admin_drawer.dart';
import '../../widgets/custom_dialogue.dart';
import 'add_doctors.dart';
import 'edit_doctor.dart';


class ShowDoctors extends StatefulWidget {
  const ShowDoctors({Key? key}) : super(key: key);

  @override
  State<ShowDoctors> createState() => _ShowDoctorsState();
}

class _ShowDoctorsState extends State<ShowDoctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: kButtonColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const AddNewDoctor());
            },
            icon: const Icon(Icons.add),
            color: kButtonColor,
          )
        ],
        title: Text(
          "Doctors",
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: kButtonColor
            )
        ),
        centerTitle: true,
      ),
      drawer: const AdminDrawer(),
      body: Obx(
              () => (doctorController.doctors.isNotEmpty)?
          ListView.builder(
              itemCount: doctorController.doctors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: BoxShow(
                    url: doctorController.doctors[index].docImage ??"",
                    title: doctorController.doctors[index].docName ?? "",
                    deleteFunction: (){
                      confirmationDialogue(title: "Confirmation",
                        bodyText: "Are you sure you want to delete the details of doctor?",
                        function: (){
                          doctorController.deleteDoctor(doctorController.doctors[index].docId??"", context).catchError((e){
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
                    updateFunction: (){
                      Get.to(EditDoctor(doctorModel: doctorController.doctors[index],));
                    },
                  ),
                );

              }):
          SizedBox(
            height: 200,
            child: Center(
                child: Text('Doctors data is empty.',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                    )
                )),
          )
      ),
    );
  }
}


class BoxShow extends StatelessWidget {
  final String url;
  final String title;
  final VoidCallback deleteFunction;
  final VoidCallback updateFunction;
  const BoxShow({required this.deleteFunction,required this.updateFunction,required this.url,required this.title,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kLightGreyColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),),
               const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: updateFunction,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: kButtonColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Icon(Icons.edit_outlined,
                            color: Colors.white,
                          )
                      ),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: deleteFunction,
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
                )
              ],
            ),
          ),
          Expanded(
            child: Image(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}