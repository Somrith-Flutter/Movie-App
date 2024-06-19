import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/core/enum/base_status_enum.dart';
import 'package:legend_cinema/core/model/fb_model.dart';
import 'package:legend_cinema/modules/landings/cinema/widgets/cinema_movie_detail.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/utils/helpers/date_helper.dart';
import 'package:legend_cinema/utils/helpers/helper_fn.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/no_data_found.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class CinemaDetail extends StatefulWidget {
  const CinemaDetail({super.key, required this.data});
  final FANDBModel data;

  @override
  State<CinemaDetail> createState() => _CinemaDetailState();
}

class _CinemaDetailState extends State<CinemaDetail> {
  bool isTextTapSelected = true;
  String selectedDay = '';
  final dateInfo = DateInfo();
  final _movie = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      _movie.fetchMoiveController(
          location: widget.data.locationType.toString().toLowerCase());
    });
    selectedDay = dateInfo.dates.first;
  }

  @override
  Widget build(BuildContext context) {
    var appBarMenu = [S.of(context).now_showing, S.of(context).details];
    return DefaultTabController(
      length: appBarMenu.length,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<HomeController>(builder: (logic) {
          final v = widget.data;
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: const BackWidget(),
                  title: TextWidget(
                    v.name,
                    size: 20.0,
                    bold: true,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                SliverToBoxAdapter(
                  child: Image.asset(v.detailImage.toString(),
                      height: 250, fit: BoxFit.cover),
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    tabs: appBarMenu.map((es) => Tab(text: es.toString())).toList(),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    labelStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    //For Selected tab
                    unselectedLabelStyle: const TextStyle(fontSize: 15),
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildNowShowing(
                          located: v.locationType.toString().toLowerCase()),
                      _buildMovieShow()
                    ],
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetail(v)
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNowShowing({required String located}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(dateInfo.dates.length, (index) {
              final date = dateInfo.dates[index];
              final day = dateInfo.dayNames[index];
              final month = dateInfo.months[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() async {
                      selectedDay = date;
                      await _movie.fetchMoiveController(location: located);
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
          const SizedBox(height: 30),
          TextWidget(
            S.of(context).now_showing,
            size: 22,
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMovieShow() {
    if (_movie.response == BaseStatusEnum.inprogress) {
      return const Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    if (_movie.response == BaseStatusEnum.failure) {
      return const NoDataFound();
    }

    return GestureDetector(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.5,
        ),
        itemCount: _movie.moive.length,
        itemBuilder: (BuildContext context, int index) {
          final data = _movie.moive[index];

          fetchImageWithRetry(
              "${AppConstant.domainKey}/${data.imageUrl.toString()}");

          return GestureDetector(
            onTap: () {
              AppRoute.route.push(context,
                  CinemaMovieDetail(data: [data], location: data.location));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
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

  Widget _buildDetail(FANDBModel v) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                S.of(context).number_of_hall,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                v.numberHall,
                size: 20,
                bold: true,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                S.of(context).opening_hour,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                v.openingHour,
                size: 20,
                bold: true,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                S.of(context).address,
                size: 18,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                v.address,
                size: 20,
                bold: true,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: AssetImage(v.mapImage.toString()),fit: BoxFit.cover)
            ),
          )
        ],
      ),
    );
  }
}