import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Screens/Appointment_Screen/show_appointment.dart';
import '../Screens/HomeScreens/show_doctors.dart';
import '../managers/preference_manager.dart';
import '/Constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_dialogue.dart';

class AdminDrawer extends StatefulWidget {

  const AdminDrawer({key}) : super(key: key);

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  File? image;
  Future pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file == null) return null;
    setImage(File(file.path));
  }
  void setImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }
  Widget? _imageWidget(BuildContext context){
    if(image == null && adminController.adminData.value.profile == null){
      return const Icon(
        Icons.add_a_photo,
        size: 40,
        color: Colors.grey,
      );
    }
    else if(image != null) {
    return Image(
    image: FileImage(image!),
    fit: BoxFit.cover,
      width: 120.0,
      height: 120.0,
    );
    }
    return null;
  }
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Obx(()=>(
         ListView(
          children: [
            SizedBox(
              height: 250,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                //padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: kLightGreyColor,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment:Alignment.centerRight,
                      child: TextButton(
                          onPressed: (){
                            if(image == null){
                              customDialogue(
                                  title: "Something went wrong",
                                  bodyText: 'Please select image from gallery',
                                  context: context
                              );
                            }
                            else{
                              imagePickerController.uploadImageToFirebase('Admin Images',PreferenceManager().getName,image!).then((url) {
                                setState(() {
                                  adminController.updateAdminData(url, context);
                                  image = null;
                                });
                              }).catchError((error) {
                                Get.snackbar(
                                  "Something went wrong",
                                  error.message.toString(),
                                  backgroundColor: const Color(0x85ffffff),
                                );
                              });
                            }
                          },
                          child: Text("Save",style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: kButtonColor
                          ),)),
                    ),
                    Stack(
                      children: [
                         CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: adminController.adminData.value.profile != null ?NetworkImage(adminController.adminData.value.profile!):null,
                          child: ClipOval(

                              child: _imageWidget(context)),
                         ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: (){
                              pickImage();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  border: Border.all(color: Colors.white,
                                      width: 2
                                  )
                              ),
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: kButtonColor,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      adminController.adminData.value.name??"Your Name",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kButtonColor
                    ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      adminController.adminData.value.email??"email@gmail.com",
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(
                Icons.class__outlined,
                color: kButtonColor,
              ),
              title: Text('Doctors',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
              ),
              ),
              onTap: () {
                Get.to(const ShowDoctors());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.access_time,
                color: kButtonColor,
              ),
              title: Text('Appointment',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),
              ),
              onTap: () {
                Get.to(const ShowAllAppointments(index:0));
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: kButtonColor,
              ),
              title: Text('Logout',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),
              ),
              onTap: () {
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
        )
      ))
    );
  }
}
