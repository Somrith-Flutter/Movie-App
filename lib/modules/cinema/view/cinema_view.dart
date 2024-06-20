import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/cinema/widgets/cinema_detail.dart';
import 'package:legend_cinema/modules/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class CinemaView extends StatefulWidget {
  const CinemaView({super.key});

  @override
  State<CinemaView> createState() => _CinemaViewState();
}

class _CinemaViewState extends State<CinemaView> {
  final fb = Get.find<FBController>();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    fb.textController.clear();
    fb.getLocations();
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(FocusNode());
    // });
  }

  @override
  void dispose() {
    // textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FBController>(builder: (logic) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: TextWidget(
              S.of(context).cinema,
              size: 22,
              bold: true,
            ),
            flexibleSpace: AppConstant.appbarTheme,
          ),
          body: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: logic.textController,
                    onChanged: (key) {
                      if (key != "" && logic.textController.text.isNotEmpty) {
                        logic.searchLocations(key);
                      } else {
                        key = "";
                        fb.getLocations();
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search,
                          color: Colors.white.withOpacity(0.8)),
                      hintText: S.of(context).search_cinema,
                      labelStyle:
                          TextStyle(color: Colors.white.withOpacity(0.8)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white.withOpacity(0.8)),
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
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: logic.fb.length,
                    itemBuilder: (context, index) {
                      final item = logic.fb[index];

                      if (logic.status == BaseStatusEnum.failure) {
                        return const Center(
                          child: NoDataFound(),
                        );
                      }

                      if (logic.status == BaseStatusEnum.inprogress) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          AppRoute.route.push(
                              context,
                              CinemaDetail(
                                data: item,
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.white70,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                item.image.toString(),
                                fit: BoxFit.cover,
                                height:
                                    250, // Adjust height as per your requirement
                              ),
                              const Gap(10),
                              ListTile(
                                title: TextWidget(
                                  item.name,
                                  size: 18.0,
                                  bold: true,
                                  maxLines: 1,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.map_pin_ellipse,
                                        color: Colors.red,
                                      ),
                                      const Gap(5.0),
                                      Flexible(
                                        child: TextWidget(
                                          item.address,
                                          size: 16.0,
                                          bold: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
