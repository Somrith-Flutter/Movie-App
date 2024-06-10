import 'package:flutter/material.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/modules/landings/f&b/widgets/f&b_combo.dart';
import 'dart:ui';

import 'package:legend_cinema/widgets/text_widget.dart';

class FBView extends StatelessWidget {
  const FBView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/f&b.jpeg",width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Adjust the sigma values for more or less blur
          child: Container(
            color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent, // Set Scaffold background color to transparent
          appBar: AppBar(
            title: const TextWidget("F&B", size: 20, bold: true),
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
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Image.asset("assets/images/f&b.jpeg"),
              const Padding(
                padding: EdgeInsets.only(top: 8, right: 12, left: 12),
                child: TextWidget(
                  "Choose Cinema",
                  size: 20,
                  bold: true,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: SizedBox(
                      height: 80,
                      child: GestureDetector(
                        onTap: (){
                          AppRoute.route.push(context, const FAndBCombo());
                        },
                        child: Card(
                          color: Colors.white70.withOpacity(0.1),
                          elevation: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 60,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/f&b.jpeg",
                                            ),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Expanded(
                                    child: TextWidget(
                                      "Hello",
                                      size: 17,
                                      bold: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
