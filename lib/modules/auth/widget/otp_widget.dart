import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/modules/auth/widget/register_form.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        leading: const BackWidget(),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget("Verification Code", size: 26, bold: true),
            const SizedBox(height: 16),
            const Row(
              children: [
                TextWidget(
                  "Enter verify code we've sent to ",
                  size: 16,
                ),
                TextWidget(
                  "(+855)",
                  size: 16,
                  color: Colors.red,
                ),
                SizedBox(width: 5),
                TextWidget(
                  "78378171",
                  size: 16,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Form(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTextField(
                      onChanged: (value){
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  const SizedBox(width: 16),
                  _buildTextField(
                      onChanged: (value){
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  const SizedBox(width: 16),
                  _buildTextField(
                      onChanged: (value){
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  const SizedBox(width: 16),
                  _buildTextField(
                      onChanged: (value){
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  const SizedBox(width: 16),
                  _buildTextField(
                      onChanged: (value){
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                  const SizedBox(width: 16),
                  _buildTextField(
                      onChanged: (value){}),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Center(
              child: Column(
                children: [
                  TextWidget("Haven't received the code?",size: 20,bold: true),
                  TextWidget("Resend",size: 20,bold: true,color: Colors.red)
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      AppRoute.route.push(context, RegisterForm());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: TextWidget(
                      S.of(context).confirm,
                      size: 16,
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
Widget _buildTextField({required void Function(String) onChanged}) {
  return Expanded(
    child: SizedBox(
      height: 68,
      child: TextFormField(
        keyboardType: TextInputType.number, // Use appropriate keyboardType if needed
        decoration: InputDecoration(
          filled: true,
          hintText: "_",
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        onChanged: onChanged,
      ),
    ),
  );
}


