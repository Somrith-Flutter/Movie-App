import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/modules/auth/controller/pick_image_controller.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late DateTime dateTime;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.appbarColor,
              // Ensure AppColor.appbarColor is defined correctly
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<PickImageController>(builder: (logic) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          cancelButton: CupertinoActionSheetAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.pop(context, 'Cancel');
                            },
                            child: const TextWidget(
                              'Cancel',
                              size: 20,
                              bold: true,
                              color: Colors.blue,
                            ),
                          ),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: const TextWidget(
                                'From Gallery',
                                size: 20,
                                bold: true,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                logic.loadImage(ImageSource.gallery);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: const TextWidget(
                                'From Camara',
                                size: 20,
                                bold: true,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                logic.loadImage(ImageSource.camera);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 50),
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.red,
                            size: 60,
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 17,
                              color: Colors
                                  .black54, // Adjusted the color to match your design
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const Center(
                child: TextWidget(
                  "Set New Profile Picture",
                  size: 18,
                  bold: true,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 32,),
              const TextWidget("Setup your profile information",size: 22,bold: true,),
              const Row(
                children: [
                  TextWidget("You've created this account with",size: 14,bold: true),
                  TextWidget("(+855)",size: 14,bold: true,color: Colors.red,),
                  SizedBox(width: 3,),
                  TextWidget("78378171",size: 14,bold: true,color: Colors.red,),
                ],
              ),
              const SizedBox(height: 30,),
              Form(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,
                              color: Colors.white.withOpacity(0.8)),
                          labelText: "First Name",
                          labelStyle:
                          TextStyle(color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.8)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white70.withOpacity(0.1),
                        ),
                        style:
                        TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      const SizedBox(height: 16,),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,
                              color: Colors.white.withOpacity(0.8)),
                          labelText: "Last Name",
                          labelStyle:
                          TextStyle(color: Colors.white.withOpacity(0.8),fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.8)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white70.withOpacity(0.1),
                        ),
                        style:
                        TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      const SizedBox(height: 16,),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.4,
                                color: Colors.black54,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const TextWidget("Done",size: 16,bold: true,),
                                    ),
                                    Expanded(
                                      child: CupertinoDatePicker(
                                        initialDateTime: dateTime,
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (date) {
                                          setState(() {
                                            dateTime = date;
                                            _dateController.text =
                                            "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.cake,
                                  color: Colors.white.withOpacity(0.8)),
                              labelText: "DD-MM-YYYY",
                              labelStyle: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white.withOpacity(0.8)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.white70.withOpacity(0.1),
                            ),
                            style: TextStyle(color: Colors.white.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 90),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const TextWidget(
                          "Continue",
                          size: 16,
                          bold: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: (){},
                        child: const TextWidget("Skip",size: 18,bold: true,))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
