import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/auth/controller/pick_image_controller.dart';
import 'package:legend_cinema/modules/auth/view/auth_view.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    this.numberPhone,
    this.isFromMoreScreen,
  });
  final String? numberPhone;
  final bool? isFromMoreScreen;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late DateTime dateTime;
  final user = Get.find<AuthController>();
  final logic = Get.find<PickImageController>();
  bool _isToggle = false;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  void _registerBtn() async {
    if (user.name.text.isEmpty) {
      _buildSnackbarMsg();
      return;
    }

    if (user.email.text.isEmpty) {
      _buildSnackbarMsg();
      return;
    }

    if (user.dob.text.isEmpty) {
      _buildSnackbarMsg();
      return;
    }

    if (user.password.text.isEmpty) {
      _buildSnackbarMsg();
      return;
    }

    if (user.confirmPassword.text.isEmpty) {
      _buildSnackbarMsg();
      return;
    }

    if (user.password.text.toString() != user.confirmPassword.text.toString()) {
      _buildMactchPasswordAndConfirmPassword();
      return;
    }

    EasyLoading.show(status: "Registering...");
    await user.registerController().then((_) async {
      if (user.status == BaseStatusEnum.success) {
        await EasyLoading.dismiss();
        AppRoute.route.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            const AuthView(
              isFromRegister: true,
            ));
        user.clear();
        _buildSuccessMsg();
      } else {
        await EasyLoading.dismiss();
        _buildInternalServerError();
      }
      return;
    });
  }

  void _uploadImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, S.of(context).cancel);
          },
          child: TextWidget(
            S.of(context).cancel,
            size: 20,
            bold: true,
            color: Colors.blue,
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: TextWidget(
              S.of(context).from_gallery,
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
            child: TextWidget(
              S.of(context).from_camera,
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
  Widget build(BuildContext context) {
    final List<String> genderOptions = [S.of(context).male, S.of(context).female, S.of(context).other];
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading:
                widget.isFromMoreScreen != false ? const BackWidget() : null,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColor.appbarColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () => _uploadImage(),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
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
                                color: Colors
                                    .black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: TextWidget(
                      S.of(context).set_new_profile,
                      size: 18,
                      bold: true,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextWidget(
                    S.of(context).set_new_profile,
                    size: 22,
                    bold: true,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        TextWidget(S.of(context).ms_create_account,
                            size: 14, bold: true),
                        const TextWidget(
                          "(+855) ",
                          size: 14,
                          bold: true,
                          color: Colors.red,
                        ),
                        TextWidget(
                          widget.numberPhone.toString().isNotEmpty
                              ? widget.numberPhone
                              : "Unkown",
                          size: 14,
                          bold: true,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: user.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,
                              color: Colors.white.withOpacity(0.8)),
                          labelText: S.of(context).username,
                          labelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
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
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: user.email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,
                              color: Colors.white.withOpacity(0.8)),
                          labelText: S.of(context).email,
                          labelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
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
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                color: Colors.black54,
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
                              labelText: "DD-MM-YYYY",
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownButtonFormField<String>(
                        value: user.selectedGender,
                        decoration: InputDecoration(
                          labelText: S.of(context).gender,
                          fillColor: Colors.white70.withOpacity(0.1),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.white.withOpacity(0.8))),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ),
                        items: genderOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            user.gender = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return S.of(context).ms_select_gender;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: _isToggle,
                        controller: user.password,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                              color: Colors.white.withOpacity(0.8)),
                          suffixIcon: IconButton(
                            onPressed: () => _togglePassword(),
                            icon: Icon(
                                _isToggle
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                          labelText: S.of(context).password,
                          labelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
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
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: user.confirmPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock,
                              color: Colors.white.withOpacity(0.8)),
                          labelText: S.of(context).re_enter_password,
                          labelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
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
                    ],
                  )),
                  const SizedBox(
                    height: 190.0,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _registerBtn(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(78, 59, 58, 58),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: TextWidget(
                    S.of(context).register,
                    size: 16,
                    bold: true,
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildSnackbarMsg() {
    return IconSnackBar.show(
      context,
      snackBarType: SnackBarType.fail,
      label: 'Pleas fill all the blank!',
      snackBarStyle: const SnackBarStyle(
        labelTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildInternalServerError() {
    return IconSnackBar.show(
      context,
      snackBarType: SnackBarType.fail,
      label: 'Password at least 6 digits!',
      snackBarStyle: const SnackBarStyle(
        labelTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildMactchPasswordAndConfirmPassword() {
    return IconSnackBar.show(
      context,
      snackBarType: SnackBarType.fail,
      label: 'Password and confirm password dose not macth!',
      snackBarStyle: const SnackBarStyle(
        labelTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSuccessMsg() {
    return IconSnackBar.show(
      context,
      snackBarType: SnackBarType.success,
      label: S.of(context).ms_sucess,
      snackBarStyle: const SnackBarStyle(
        labelTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
