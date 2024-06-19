import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/landings/home/model/home_model.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/utils/helpers/date_helper.dart';
import 'package:legend_cinema/utils/helpers/helper_fn.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

// ignore: must_be_immutable
class CinemaMovieDetail extends StatefulWidget {
  CinemaMovieDetail({super.key, required this.data, this.location});

  List<MoiveModel> data = [];
  String? location;

  @override
  State<CinemaMovieDetail> createState() => _CinemaMovieDetailState();
}

class _CinemaMovieDetailState extends State<CinemaMovieDetail> {
  final dateInfo = DateInfo();
  String selectedDay = '';
  final locat = Get.find<FBController>();
  final _movie = Get.find<HomeController>();
  String? cinema;
  MoiveModel? newMoive;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      onInit();
    });
    selectedDay = dateInfo.dates.first;
  }

  onInit() {
    for (var v in widget.data) {
      debugPrint("id => ${v.id}");
      _movie.fetchMoiveController(
          location: widget.location.toString().toLowerCase(), id: v.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newMoive != null) ...[
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "${AppConstant.domainKey}/${newMoive?.imageUrl}",
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                  Positioned(
                      top: 50.0,
                      left: 16.0,
                      right: 16.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _movie.fetchMoiveController(
                                  location: widget.location);
                              Get.back();
                            },
                            child: Container(
                                margin: const EdgeInsets.all(7),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 1),
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.arrow_back)),
                          ),
                          Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.5)),
                              child: GestureDetector(
                                  onTap: () async {
                                    await shareNetworkImage(
                                        "${AppConstant.domainKey}/${newMoive?.imageUrl}");
                                    setState(() {});
                                  },
                                  child: const Icon(Icons.ios_share_outlined))),
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      newMoive?.title,
                      size: 20,
                      bold: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextWidget(
                      "2D",
                      size: 26,
                      bold: true,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _builderRow(
                        icon: Icons.folder_shared_rounded,
                        text: S.of(context).genre,
                        subText: newMoive!.genre.toString()),
                    const SizedBox(
                      height: 10,
                    ),
                    _builderRow(
                        icon: Icons.access_time_filled,
                        text: S.of(context).duration,
                        subText: newMoive!.duration.toString()),
                    const SizedBox(
                      height: 10,
                    ),
                    _builderRow(
                        icon: Icons.date_range,
                        text: S.of(context).release,
                        subText: newMoive!.release.toString()),
                    const SizedBox(
                      height: 10,
                    ),
                    _builderRow(
                        icon: Icons.visibility_off,
                        text: S.of(context).classification,
                        subText: newMoive!.classification.toString())
                  ],
                ),
              )
            ] else ...[
              for (var v in widget.data) ...[
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: "${AppConstant.domainKey}/${v.imageUrl}",
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    ),
                    Positioned(
                        top: 50.0,
                        left: 16.0,
                        right: 16.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _movie.fetchMoiveController(
                                    location: widget.location);
                                Get.back();
                              },
                              child: Container(
                                  margin: const EdgeInsets.all(7),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.5),
                                          width: 1),
                                      shape: BoxShape.circle),
                                  child: const Icon(Icons.arrow_back)),
                            ),
                            Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.5)),
                                child: GestureDetector(
                                    onTap: () async {
                                      await shareNetworkImage(
                                          "${AppConstant.domainKey}/${v.imageUrl}");
                                    },
                                    child:
                                        const Icon(Icons.ios_share_outlined)))
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        v.title,
                        size: 20,
                        bold: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const TextWidget(
                        "2D",
                        size: 26,
                        bold: true,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _builderRow(
                          icon: Icons.folder_shared_rounded,
                          text: S.of(context).genre,
                          subText: v.genre.toString()),
                      const SizedBox(
                        height: 10,
                      ),
                      _builderRow(
                          icon: Icons.access_time_filled,
                          text: S.of(context).duration,
                          subText: v.duration.toString()),
                      const SizedBox(
                        height: 10,
                      ),
                      _builderRow(
                          icon: Icons.date_range,
                          text: S.of(context).release,
                          subText: v.release.toString()),
                      const SizedBox(
                        height: 10,
                      ),
                      _builderRow(
                          icon: Icons.visibility_off,
                          text: S.of(context).classification,
                          subText: v.classification.toString())
                    ],
                  ),
                )
              ],
            ],
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.white.withOpacity(0.5),
                height: 3,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextWidget(
                S.of(context).dis_movie,
                size: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _buildBottomSheet(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2, color: Colors.white.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      cinema ?? widget.location.toString().toUpperCase(),
                      size: 18,
                      bold: true,
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: List.generate(dateInfo.dates.length, (index) {
                  final date = dateInfo.dates[index];
                  final day = dateInfo.dayNames[index];
                  final month = dateInfo.months[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = date;
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 80,
                            width: 70,
                            decoration: BoxDecoration(
                              border: selectedDay == date
                                  ? Border.all(color: Colors.red, width: 2)
                                  : Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 20,
                            child: TextWidget(
                              day,
                              size: 12,
                            ),
                          ),
                          Positioned(
                            top: 25,
                            left: 20,
                            child: TextWidget(
                              date,
                              bold: true,
                              size: 22,
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 25,
                            child: TextWidget(
                              month,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            _buildMoiveShow(context)
          ],
        ),
      ),
    );
  }

  Widget _builderRow(
      {required IconData icon, required String text, required String subText}) {
    return Row(children: [
      Icon(
        icon,
        color: Colors.red,
      ),
      const SizedBox(
        width: 10,
      ),
      TextWidget(text, bold: true, color: Colors.grey),
      TextWidget(
        subText,
        bold: true,
      )
    ]);
  }

  Future _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    S.of(context).cinema,
                    size: 19,
                    bold: true,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3), width: 2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Divider(
                color: Colors.white.withOpacity(0.3),
                height: 2,
              ),
              const SizedBox(height: 10.0),
              Flexible(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: locat.fb.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        Future.delayed(const Duration(milliseconds: 300));
                        await _movie.fetchMoiveController(
                            location: locat.fb[index].locationType
                                .toString()
                                .toLowerCase());
                        cinema = locat.fb[index].name.toString();
                        setState(() {});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 8),
                              TextWidget(
                                locat.fb[index].name,
                                size: 18,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Divider(
                            color: Colors.white.withOpacity(0.3),
                            height: 0.5,
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoiveShow(BuildContext context) {
    if (_movie.response == BaseStatusEnum.inprogress) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (_movie.response == BaseStatusEnum.failure) {
      return const Center(
        child: NoDataFound(),
      );
    }

    return GestureDetector(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.1 / 4,
        ),
        itemCount: _movie.moive.length,
        itemBuilder: (BuildContext context, int index) {
          debugPrint("${_movie.moive.length}");
          final data = _movie.moive[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                newMoive = data;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${AppConstant.domainKey}/${data.imageUrl.toString()}",
                        fit: BoxFit.cover,
                        height: 300,
                        errorWidget: (context, url, error) => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      TextWidget(
                        data.release,
                        bold: true,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: TextWidget(
                            data.classification,
                            color: Colors.black,
                            bold: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextWidget(
                    data.title,
                    color: Colors.white,
                    size: 16,
                    bold: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}