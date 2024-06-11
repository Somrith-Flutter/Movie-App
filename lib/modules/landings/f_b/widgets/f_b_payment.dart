import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class FBPayment extends StatefulWidget {
  const FBPayment({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  State<FBPayment> createState() => _FBPaymentState();
}

class _FBPaymentState extends State<FBPayment> {
  String _selectedPaymentMethod = 'KHQR';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/f&b.jpeg",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: const BackWidgetScreen(),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget("Checkout", size: 20, bold: true),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white.withOpacity(0.8)),
                            color: Colors.white70.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget("Guest Information",
                                    size: 20, bold: true),
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email,
                                        color: Colors.white.withOpacity(0.8)),
                                    labelText: "Email",
                                    labelStyle:
                                        TextStyle(color: Colors.white.withOpacity(0.8)),
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white.withOpacity(0.8)),
                            color: Colors.white70.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Payment Method",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/member-card.png",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          "Member points",
                                          size: 16,
                                          bold: true,
                                          color: Colors.grey,
                                        ),
                                        TextWidget("Available", color: Colors.grey),
                                      ],
                                    ),
                                    const Spacer(),
                                    Radio<String>(
                                      value: 'Member points',
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedPaymentMethod = value!;
                                        });
                                      },
                                      activeColor: Colors.white70,
                                      fillColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white.withOpacity(0.5),
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        "assets/icons/khqr.png",
                                        width: 50,
                                        fit: BoxFit.cover,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          "ABA KHQR",
                                          size: 16,
                                          bold: true,
                                          color: Colors.grey,
                                        ),
                                        TextWidget("Scan to pay with any baking app",
                                            color: Colors.grey),
                                      ],
                                    ),
                                    const Spacer(),
                                    Radio<String>(
                                      value: 'KHQR',
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedPaymentMethod = value!;
                                        });
                                      },
                                      activeColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.white.withOpacity(0.5),
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/credit-card.png",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          "Debit/Credit Card",
                                          size: 16,
                                          bold: true,
                                          color: Colors.grey,
                                        ),
                                        TextWidget("Available", color: Colors.grey),
                                      ],
                                    ),
                                    const Spacer(),
                                    Radio<String>(
                                      value: 'Credit Card',
                                      groupValue: _selectedPaymentMethod,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedPaymentMethod = value!;
                                        });
                                      },
                                      activeColor: Colors.white70,
                                      fillColor: MaterialStateProperty.all(Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Expanded(
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                              "Pay. \$${widget.totalPrice.toStringAsFixed(2)}",
                              size: 20,
                              bold: true,
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
