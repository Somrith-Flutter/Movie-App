import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/modules/landings/f_b/controller/f_b_controller.dart';
import 'package:legend_cinema/modules/landings/home/controller/home_controller.dart';
import 'package:legend_cinema/modules/landings/home/widgets/movie_item.dart';
import 'package:legend_cinema/modules/landings/home/widgets/time_line_item.dart';
import 'package:legend_cinema/shared/v_globle.dart';
import 'package:legend_cinema/widgets/dot_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;
  final user = Get.find<AuthController>();
  final HomeController controller = Get.find();
  final FBController filter = Get.find();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      user.fetchUserController();
    });

    controller.selectedDay = controller.dateInfo.dates.first;
    controller.selectedMonth = controller.dateInfo.dates.first;
    
    _pageController = PageController(viewportFraction: 0.90);
    controller.timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= images.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 26, 25, 25).withOpacity(0.9),
        centerTitle: true,
        title: const TextWidget(
          AppConstant.appName, 
          size: 22, 
          bold: true,
        ),
        flexibleSpace: AppConstant.appbarTheme,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: accessToken.$.isNotEmpty ? Stack(
        children: [
          _buildBody(),
          Positioned(
            bottom: 120, 
            right: 15,
            child: ClipOval(
              child: FloatingActionButton(
                onPressed: () {
                
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ) : _buildBody(),
    );
  }

  Widget _buildBody(){
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(controller.currentImagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Column(
                        children: [
                          _buildFilterInput(),
                          const Gap(12),
                          _buildSlideImages(),
                          const Gap(14),
                          DotIndicatorWidget(currentPage: controller.currentPage, itemCount: images.length), 
                          const Gap(12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _buildTabView(),
                controller.isNowShowing ? _buildNowShwing() : _buildComingSoon(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterInput(){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
          _buildBottomSheet(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  controller.cinema == ""
                      ? 'All Cinemas'
                      : controller.cinema,
                  size: 16,
                ),
                const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
                    const TextWidget(
                      "Cinema",
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
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filter.fb.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              controller.cinema = filter.fb[index].name.toString();
                              filter.getDetailedData(filter
                                  .fb[index].locationType
                                  .toString());
                            });
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.red),
                                  const SizedBox(width: 8),
                                  TextWidget(
                                    filter.fb[index].name.toString(),
                                    size: 16,
                                    bold: true,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Divider(
                                  color: Colors.white.withOpacity(0.3),
                                  height: 0.5),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
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

  Widget _buildSlideImages() {
    return SizedBox(
      width: 600,
      height: 600,
      child: PageView.builder(
        controller: _pageController,
        itemCount: images.length,
        itemBuilder: (context, index) {
          controller.currentImagePath = images[index]; 
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        onPageChanged: (int index) {
          setState(() {
            controller.currentPage = index;
            controller.currentImagePath = images[index]; 
          });
          if (index == images.length - 1) {
            Future.delayed(const Duration(seconds: 1), () {
              _pageController.jumpToPage(0);
            });
          }
        },
      ),
    );
  }

  Widget _buildTabView(){
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 16, right: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isNowShowing = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.isNowShowing ? Colors.red : Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: TextWidget(
                          'Now Showing',
                          bold: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isNowShowing = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.isNowShowing ? Colors.grey.shade600 : Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: TextWidget(
                            'Coming Soon',
                            bold: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNowShwing(){
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildTimeLine(),
        BuildTimeLineItems(
          movies: controller.selectedDay == controller.dateInfo.dates[1]
            ? movie1 : controller.selectedDay == controller.dateInfo.dates[2] 
              ? movie2 : controller.selectedDay == controller.dateInfo.dates[3]
                ? movie3 : movie4
        ),
      ],
    );
  }

  Widget _buildTimeLine() {
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
                children: List.generate(controller.dateInfo.dates.length, (index) {
                  final date = controller.dateInfo.dates[index];
                  final day = controller.dateInfo.dayNames[index];
                  final month = controller.dateInfo.months[index];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.selectedDay = date;
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
                              border: controller.selectedDay == date
                                  ? Border.all(color: Colors.red, width: 2)
                                  : Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 20,
                            child: TextWidget(day, size: 12,),
                          ),
                          Positioned(
                            top: 25,
                            left: 20,
                            child: TextWidget(date, bold: true, size: 22,),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 25,
                            child: TextWidget(month, size: 12,),
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

  Widget _buildComingSoon(){
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildMonthUpComing(),
        BuildTimeLineItems(
          movies: controller.selectedMonth == controller.dateInfo.dates[1] 
            ? movie1 : controller.selectedMonth == controller.dateInfo.dates[2] 
              ? movie2 : controller.selectedMonth == controller.dateInfo.dates[3] 
                ? movie3 : movie4,
        ),
      ],
    );
  }

  Widget _buildMonthUpComing(){
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
                children: List.generate(controller.dateInfo.dates.length, (index) {
                  final date = controller.dateInfo.dates[index];
                  final month = controller.dateInfo.months[index];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.selectedMonth = date;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: controller.selectedMonth == date
                              ? Border.all(color: Colors.red, width: 2)
                              : Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: TextWidget(month, size: 12,)),
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
}