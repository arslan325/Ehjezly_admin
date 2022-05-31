import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '/Constant/constant.dart';
import '/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body:
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Text("Welcome to",style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kButtonColor
                  ),),
                ),
                const SizedBox(height: 10),
                Text("Ehjezly Admin",style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kButtonColor
                ),),
                const SizedBox(height: 50),
                SizedBox(
                  width: width*0.85,
                  child: const Image(
                    image: AssetImage('images/Lifesavers Bust.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 70,),
                CustomButton(title: 'Login',
                  clickFuction:
                      (){
                        Get.to(const LoginScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
