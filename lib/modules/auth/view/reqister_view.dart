import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/auth/widget/register_form.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final register = Get.find<AuthController>();

  void _register() async {
    if(register.number.text.isEmpty){
      IconSnackBar.show(
        context,
        snackBarType:
            SnackBarType.fail,
        label:
            'Phone number is invalid!',
        snackBarStyle:
            const SnackBarStyle(
          labelTextStyle: TextStyle(
              color: Colors.white),
        ),
      );
      return;
    }

    AppRoute.route.push(context, RegisterForm(numberPhone: register.number.text));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
            leading: const BackWidget(),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColor.appbarColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
            ),
          ),
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                TextWidget(
                  S.of(context).register,
                  size: 24,
                  bold: true,
                  font: 'KhmerFont',
                ),
                const Gap(20),
                const TextWidget(
                  'បញ្ចូលលេខទូរស័ព្ទរបស់អ្នកដើម្បីចូលទៅកាន់គណនីរបស់អ្នក',
                  size: 16,
                  font: 'KhmerFont',
                ),
                const Gap(40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AssetPath.flagkhmer,
                        width: 24,
                        height: 24,
                      ),
                      const Gap(8),
                      const TextWidget(
                        '+855',
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: register.number,
                          keyboardType: TextInputType.phone,
                          validator: (value) => (value),
                          decoration: InputDecoration(
                            hintText: S.of(context).phone_number,
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Khmer',
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _register(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(143, 72, 71, 71),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: TextWidget(
                          S.of(context).continues,
                          bold: true,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}