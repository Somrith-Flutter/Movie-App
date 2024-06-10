import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
   bool isPhoneTabSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidgetScreen(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            TextWidget(
              S.of(context).login,
              size: 24,
            ),
            const Gap(16),
            const TextWidget(
              'អាស័យដ្ឋានអ៊ីមែលរបស់អ្នក ឬលេខទូរស័ព្ទរបស់អ្នក',
              size: 16,
            ),
            const Gap(32),
            Row(
              children:[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPhoneTabSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPhoneTabSelected ? Colors.grey[800] : Colors.red,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: TextWidget(
                            S.of(context).email,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPhoneTabSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPhoneTabSelected ? Colors.red : Colors.grey[800],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: TextWidget(
                            S.of(context).phone_number,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            isPhoneTabSelected ? buildPhoneNumberInput() : buildEmailInput(),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: TextWidget(
                      S.of(context).login,
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

  Widget buildPhoneNumberInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children:[
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
            child: TextField(
              keyboardType: TextInputType.phone,
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
    );
  }

  Widget buildEmailInput() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children:[
              const Icon(Icons.person, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: S.of(context).email,
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
        const Gap(18),
        Container(
           padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
          child: Row(
            children:[
              const Icon(Icons.lock, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: S.of(context).password,
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
              const Icon(Icons.visibility_off, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}