import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:legend_cinema/modules/landings/f&b/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class FAndBCombo extends StatelessWidget {
  const FAndBCombo({super.key});

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
          // Adjust the sigma values for more or less blur
          child: Container(
            color: Colors.black.withOpacity(0.5),
            // Adjust the opacity as needed
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: const BackWidgetScreen(),
            title: const TextWidget("F&B", size: 20, bold: true),
            centerTitle: true,
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
              Stack(
                children: [
                  Image.asset("assets/images/f&b.jpeg"),
                  Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          _buildBottomSheet(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black54.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget("Legend Premium Exchange Square",
                                    size: 18),
                                Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: SizedBox(
                      height: 130,
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
                                    width: 100,
                                    height: 100,
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
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          "Combo1",
                                          size: 17,
                                          bold: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        TextWidget(r"$" "${5.0}",
                                            size: 16,
                                            bold: true,
                                            color: Colors.red)
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red[600]),
                                      child: const Icon(
                                        Icons.add,
                                        size: 30,
                                      )),
                                )
                              ],
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

Future _buildBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    "Cinema",
                    size: 19,
                    bold: true,
                  ),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white.withOpacity(0.3), width: 2),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Divider(
                color: Colors.white.withOpacity(0.3),
                height: 2,
              ),
            )
          ],
        ),
      );
    },
  );
}
