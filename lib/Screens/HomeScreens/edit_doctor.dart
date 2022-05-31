import 'dart:io';

import 'package:ehjezly_admin/Models/doctor_model.dart';
import 'package:ehjezly_admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range/time_range.dart';

import '../../Constant/constant.dart';
import '../../widgets/custom_dialogue.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loading_widget.dart';

class EditDoctor extends StatefulWidget {
  final DoctorModel doctorModel;
  const EditDoctor({required this.doctorModel,Key? key}) : super(key: key);

  @override
  State<EditDoctor> createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  final DateRangePickerController _datePickerController = DateRangePickerController();
  final TextEditingController _doctorNameTextEditController = TextEditingController();
  final TextEditingController _addTreatmentTextEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  File? image;
  List<DateTime> date = [];
  TimeRangeResult? _timeRangeResult;
  TimeRangeResult? initialRange;
  List<String> treatment =[];
  List<String> tempTreatment =[];
  DateTime? from;
  DateTime? to;
  TimeOfDay? t1;
  TimeOfDay? t2;
  void _onDateChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      date = args.value;
    });
  }
  void _onTimeRangeCompleted(TimeRangeResult _timeRange) {
    setState(() {
      _timeRangeResult = _timeRange;
    });
  }
List<DateTime> date1 =[];
  List<DateTime> time1 =[];
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
  @override
  void initState() {
    super.initState();
    _doctorNameTextEditController.text = widget.doctorModel.docName??"";
    for(int i =0;i<widget.doctorModel.dateTime!.length;i++){
      date1.add(widget.doctorModel.dateTime![i].toDate());
    }
    date = date1;
    for(int i =0;i<widget.doctorModel.treatment!.length;i++){
      tempTreatment.add(widget.doctorModel.treatment![i]);
    }
    for(int i =0;i<widget.doctorModel.unavailableTime!.length;i++){
      time1.add(widget.doctorModel.unavailableTime![i].toDate());
    }

     t1 = TimeOfDay.fromDateTime(widget.doctorModel.unavailableTime![0].toDate());
    t2 = TimeOfDay.fromDateTime(widget.doctorModel.unavailableTime![1].toDate());
   _datePickerController.selectedDates = date1;
   initialRange = TimeRangeResult(t1!, t2!);
    //  imagePickerController.disposeImage();
  }
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop:() async{
        //  imagePickerController.disposeImage();
        return true;
      },
      child:
      Scaffold(
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height*0.020,),
                InkWell(
                  onTap: (){
                    pickImage();
                  },
                  child: Container(
                    height: height*.27,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)
                    ),
                    child: image == null ? Image.network(widget.doctorModel.docImage??"",fit: BoxFit.fill) : Image(
                      image: FileImage(image!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          SizedBox(height: height*0.020,),
                Text("Select Unavailable Doctor Dates".toString(),style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),),
                SizedBox(height: height*0.010,),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: kBackgroundColor,
                      border: Border.all(color: Colors.black12)
                  ),
                  child: SfDateRangePicker(
                    controller: _datePickerController,
                    backgroundColor: kBackgroundColor,
                    selectionColor: kButtonColor,
                    showNavigationArrow: true,
                    todayHighlightColor: kButtonColor,
                    monthCellStyle: const DateRangePickerMonthCellStyle(
                      todayTextStyle: TextStyle(color: kButtonColor),
                    ),
                    toggleDaySelection: true,
                    view: DateRangePickerView.month,
                    enablePastDates : false,
                    selectionMode: DateRangePickerSelectionMode.multiple,
                    // monthViewSettings: DateRangePickerMonthViewSettings(blackoutDates:date),
                    onSelectionChanged: (val){
                      _onDateChanged(val);
                    },
                  ),
                ),
                SizedBox(height: height*0.020,),
                (date.isNotEmpty)?ListView.builder(
                    itemCount: date.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text(index.toString()+" :"
                            ,style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),),
                          const SizedBox(width: 10,),
                          Text(DateFormat('yyyy-MM-dd').format(date[index]),
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),),
                        ],),
                      );
                    }):Container(),
                SizedBox(height: height*0.010,),
                Text("Select Unavailable Doctor Time",style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),),
                SizedBox(height: height*0.020,),
                TimeRange(
                  activeBackgroundColor: kButtonColor,
                  backgroundColor: kLightTextColor,
                  fromTitle: const Text(
                    'From',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  toTitle: const Text(
                    'To',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  timeBlock: 60,
                  initialRange: initialRange,
                  onRangeCompleted: (range) =>
                      setState(() => _onTimeRangeCompleted(range!)),
                  firstTime: const TimeOfDay(hour: 1, minute: 00),
                  lastTime: const TimeOfDay(hour: 24, minute: 00),
                  borderColor: Colors.transparent,
                  textStyle: const TextStyle(color: Colors.white),
                  activeTextStyle: const TextStyle(color: Colors.white),
                ),
                SizedBox(height: height*0.020,),
                Text("Add Treatment",style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),),
                SizedBox(height: height*0.020,),
                Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey2,
                        child: CustomTextField(
                            controller: _addTreatmentTextEditController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please enter treatment';
                              }
                              return null;
                            },
                            hintText: "Treatment"),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        if(_formKey2.currentState!.validate()){
                          setState(() {
                            tempTreatment.clear();
                              treatment.add(_addTreatmentTextEditController.text);

                          });
                          _addTreatmentTextEditController.clear();
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: kButtonColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Icon(Icons.add,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height*0.020,),
                ListView.builder(
                    itemCount: treatment.isEmpty?tempTreatment.length:treatment.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text(index.toString()+" :"
                            ,style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),),
                          const SizedBox(width: 10,),
                          Text(treatment.isEmpty?tempTreatment[index]:treatment[index],
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),),
                        ],),
                      );
                    }),
                Column(
                  children: [
                    SizedBox(height: height*0.050,),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                                controller: _doctorNameTextEditController,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Please enter doctor name';
                                  }
                                  return null;
                                },
                                hintText: "name"),
                          ],
                        )
                    ),
                    SizedBox(height: height*0.025,),
                    CustomButton(title: 'Update Doctor',
                      clickFuction: (){
                      if(_timeRangeResult != null){
                        t1 = _timeRangeResult!.start;
                        t2 = _timeRangeResult!.end;
                      }

                        DateTime now = DateTime.now();
                        from = DateTime(now.year, now.month, now.day, t1!.hour, t1!.minute);
                        to = DateTime(now.year, now.month, now.day, t2!.hour, t2!.minute);
                        if(image == null && _formKey.currentState!.validate()){
                          loadingDialogue(context: context, message: 'Updating doctor details');
                          DoctorModel doctorModel = DoctorModel(
                            docName: _doctorNameTextEditController.text,
                            docId: widget.doctorModel.docId,
                            dateTime:date,
                            docImage: widget.doctorModel.docImage,
                            treatment: treatment.isEmpty?tempTreatment:treatment,
                            unavailableTime: [from,to]
                          );
                          doctorController.updateDoctor(doctorModel,context);
                          Get.back();
                          Get.back();
                        }
                        else if(_formKey.currentState!.validate()){
                          loadingDialogue(context: context, message: 'Updating doctor details');
                          imagePickerController.uploadImageToFirebase('Doctors Images',_doctorNameTextEditController.text,image!).then((url) {
                            setState(() {
                              DoctorModel doctorModel = DoctorModel(
                                docName: _doctorNameTextEditController.text,
                                docId: widget.doctorModel.docId,
                                dateTime: date,
                                docImage: url,
                                treatment: treatment.isEmpty?tempTreatment:treatment,
                                  unavailableTime: [from,to],

                              );
                              doctorController.updateDoctor(doctorModel,context);
                              Navigator.pop(context);
                              Get.back();
                            });
                          }).catchError((error) {
                            Navigator.pop(context);
                            Get.snackbar(
                              "Something went wrong",
                              error.message.toString(),
                              backgroundColor: const Color(0x85ffffff),
                            );
                          });
                        }
                      },
                    ),
                    SizedBox(height: height*0.025,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
