import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/auth/controller/pick_image_controller.dart';
import 'package:legend_cinema/widgets/custdropdown.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key, this.numberPhone});
  final String? numberPhone;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final logic = Get.find<PickImageController>();
  final user = Get.find<AuthController>();
  late DateTime dateTime;
  void _uploadImage() {
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
  }

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          centerTitle: true,
          title: const TextWidget(
            'Profile',
            size: 22,
            bold: true,
          ),
          flexibleSpace: AppConstant.appbarTheme,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const TextWidget(
                  'Save',
                  bold: true,
                  color: Colors.red,
                ))
          ],
        ),
        backgroundColor: AppColor.primaryColor,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            // for (var us in user.uu) ...[
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => _uploadImage(),
                child: Stack(
                  children: [
                    Container(
                      width: 85,
                      height: 85,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "${AppConstant.domainKey}/${user.uu?.imageProfile}",
                            fit: BoxFit.cover,
                            height: double.maxFinite,
                            width: double.maxFinite,
                          )),
                    ),
                    Positioned(
                      bottom: 10,
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
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(15),
            const Center(
              child: TextWidget(
                "Set New Profile Picture",
                size: 12,
                bold: true,
                color: Colors.red,
              ),
            ),
            const Gap(30),
            const TextWidget(
              "Personal Information",
              size: 20,
              bold: true,
            ),
            const Gap(15),
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: user.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,
                        color: Colors.white.withOpacity(0.8)),
                    labelText: user.uu?.name.toString(),
                    hintText: '- -',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.6)),
                    ),
                    filled: true,
                    fillColor: Colors.white70.withOpacity(0.1),
                  ),
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: const Color.fromARGB(137, 229, 225, 225)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                  child: CustDropDown(
                    color: Colors.black54,
                    maxListHeight: 150,
                    items: const [
                      CustDropdownMenuItem(
                        value: "Male",
                        child: Text(
                          "Male",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      CustDropdownMenuItem(
                        value: "Female",
                        child: Text(
                          "Female",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      CustDropdownMenuItem(
                        value: "Other",
                        child: Text(
                          "Other",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    hintText: user.gender != 'null' ? user.gender.toString() : "Gender",
                    borderRadius: 5,
                    onChanged: (val) {
                      user.selectedGender = val;
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const TextWidget(
                                  "Done",
                                  size: 16,
                                  bold: true,
                                ),
                              ),
                              Expanded(
                                child: CupertinoDatePicker(
                                  initialDateTime: dateTime,
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (date) {
                                    setState(() {
                                      dateTime = date;
                                      user.dob.text =
                                          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";

                                      debugPrint(user.dob.text);
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
                    child: TextFormField(
                      controller: user.dob,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.cake,
                            color: Colors.white.withOpacity(0.8)),
                        labelText: user.uu?.dateOfBirth,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.6)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.6)),
                        ),
                        filled: true,
                        fillColor: Colors.white70.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                const Gap(30),
                const Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    'Content Information',
                    size: 20,
                    bold: true,
                  ),
                ),
                const Gap(20),
                TextFormField(
                  obscureText: true,
                  controller: user.email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,
                        color: Colors.white.withOpacity(0.8)),
                    labelText: user.uu?.email.toString(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.6)),
                    ),
                    filled: true,
                    fillColor: Colors.white70.withOpacity(0.1),
                  ),
                ),
                const Gap(15),
                buildPhoneNumberInput()
              ],
            )),
          ],
          // ],
        ),
      ),
    );
  }

  Widget buildPhoneNumberInput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              Image.asset(
                AssetPath.flagkhmer,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                '+855',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: user.number,
                  decoration: InputDecoration(
                    hintText: user.uu?.phone,
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
