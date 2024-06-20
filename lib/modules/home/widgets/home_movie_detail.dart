import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/home/widgets/movie_item.dart';
import 'package:legend_cinema/modules/home/widgets/time_line_item.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/utils/helpers/date_helper.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeMovieDetail extends StatefulWidget {
  final Movies list;
  const HomeMovieDetail({super.key, required this.list});

  @override
  State<HomeMovieDetail> createState() => _HomeMovieDetailState();
}

class _HomeMovieDetailState extends State<HomeMovieDetail> {
  final dateInfo = DateInfo();
  String selectedDay = '';
  String selectedCinema = "Legend Eden Garden";
  final FBController controller = Get.find();
  bool isSwitchDetails = false;
  Movies? currentMovie;

  @override
  void initState() {
    super.initState();
    selectedDay = dateInfo.dates.first;
    currentMovie = widget.list;
  }

  Future<void> shareAssetImage(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);

      // Write image to a temporary file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/temp_image.png').create();
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // ignore: deprecated_member_use
      await Share.shareFiles([file.path], text: 'Check out this image!');
    } catch (e) {
      debugPrint('Error sharing asset image: $e');
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
            Stack(
              children: [
                Image.asset(
                  currentMovie?.image ?? widget.list.image!,
                  fit: BoxFit.cover,
                  height: 420,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                            margin: const EdgeInsets.all(7),
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white,width: 1),
                                shape: BoxShape.circle
                            ),
                            child: const  Icon(Icons.arrow_back ,color: Colors.white,)
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await shareAssetImage(widget.list.image!);
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: const Icon(Icons.ios_share_outlined),
                        ),
                      ),
                    ],
                  ),
                )

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
                    currentMovie?.title ?? widget.list.title,
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
                      subText: currentMovie?.genre ?? widget.list.genre!),
                  const SizedBox(
                    height: 10,
                  ),
                  _builderRow(
                      icon: Icons.access_time_filled,
                      text: S.of(context).duration,
                      subText: currentMovie?.duration ?? widget.list.duration!),
                  const SizedBox(
                    height: 10,
                  ),
                  _builderRow(
                      icon: Icons.date_range,
                      text: S.of(context).release,
                      subText: currentMovie?.release ?? widget.list.release!),
                  const SizedBox(
                    height: 10,
                  ),
                  _builderRow(
                      icon: Icons.visibility_off,
                      text: S.of(context).classification,
                      subText: currentMovie?.classification ?? widget.list.classification!)
                ],
              ),
            ),
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
                      selectedCinema,
                      size: 18,
                      bold: true,
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const Gap(15),
            _buildSwitchingMovies(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchingMovies(BuildContext context) {
    List<Movies> allMovies = [];
    int selectedIndex = dateInfo.dates.indexOf(selectedDay);
    for (int i = selectedIndex; i < dateInfo.dates.length; i++) {
      List<Movies> moviesToAdd = [];
      if (selectedCinema == controller.fb.first.name) {
        switch (i) {
          case 0:
            moviesToAdd = [...movie1];
            break;
          case 1:
            moviesToAdd = [...movie2, ...movie1];
            break;
          case 2:
            moviesToAdd = [...movie3, ...movie2, ...movie1];
            break;
          case 3:
            moviesToAdd = [...movie4, ...movie3, ...movie2, ...movie1];
            break;
          default:
            moviesToAdd = [];
        }
      } else {
        switch (i) {
          case 0:
            moviesToAdd = [...movie5];
            break;
          case 1:
            moviesToAdd = [...movie6, ...movie5];
            break;
          case 2:
            moviesToAdd = [...movie7, ...movie6, ...movie5];
            break;
          case 3:
            moviesToAdd = [...movie8, ...movie7, ...movie6, ...movie5];
            break;
          default:
            moviesToAdd = [];
        }
      }
      allMovies.addAll(moviesToAdd);
      if (i == selectedIndex) {
        break;
      }
    }

    return ListView(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildTimeLine(context),
        BuildTimeLineItems(
          movies: allMovies,
          isdetails: true,
          switcer: (Movies movie) {
            setState(() {
              currentMovie = movie;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTimeLine(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          height: 100,
          width: 300,
          child: Column(
            children: [
              Row(
                children: List.generate(dateInfo.dates.length, (index) {
                  final date = dateInfo.dates[index];
                  final day = dateInfo.dayNames[index];
                  final month = dateInfo.months[index];
                  return Expanded(
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
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                              day == "Today" ? S.of(context).today : day,
                              size: 14,
                              bold: true,
                            ),
                          ),
                          Positioned(
                            bottom: 35,
                            left: 25,
                            child: TextWidget(
                              date.split('/')[0],
                              size: 16,
                              bold: true,
                            ),
                          ),
                          Positioned(
                            top: 55,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _builderRow({required IconData icon, required String text, required String subText}) {
    return Row(children: [
      Icon(
        icon,
        color: Colors.red,
      ),
      const SizedBox(
        width: 10,
      ),
      TextWidget(text, bold: true, color: Colors.grey),
      Flexible(
        child: TextWidget(
          subText,
          bold: true,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ]);
  }

  Future _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Colors.white.withOpacity(0.3),
                  height: 2,
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.fb.length,
                  itemBuilder: (context, index) {
                    String cinemaName = controller.fb[index].name ?? "Unknown";
                    bool isSelected = selectedCinema == cinemaName;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCinema = cinemaName;
                              selectedDay = dateInfo.dates.first; 
                              currentMovie = (selectedCinema == controller.fb.first.name
                                ? movie1[0] 
                                : movie5[0]); 
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.red),
                                const SizedBox(width: 8),
                                TextWidget(
                                  cinemaName,
                                  size: 16,
                                  bold: true,
                                  color: isSelected ? Colors.red : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.white.withOpacity(0.3), height: 0.5),
                      ],
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
}