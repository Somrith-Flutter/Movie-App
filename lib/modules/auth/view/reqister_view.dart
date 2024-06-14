import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/auth/widget/otp_widget.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onPressed: () {
                        AppRoute.route.push(context, OtpWidget());
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
                        "Get OTP",
                        bold: true,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}