import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:legend_cinema/constants/asset_path.dart';
import 'package:legend_cinema/modules/auth/controller/auth_controller.dart';
import 'package:legend_cinema/widgets/dot_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

List<String> images = [
  AssetPath.story1,
  AssetPath.story2,
  AssetPath.story3,
  AssetPath.story4,
  AssetPath.story5,
  AssetPath.story6,
  AssetPath.story7,
  AssetPath.story8,
  AssetPath.story9,
  AssetPath.story10,
];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;
  final user = Get.find<AuthController>();
  late Timer _timer;
  bool isNowShowing = true;
  int selectedIndex = 0;
  int _currentPage = 0;
  String _currentImagePath = images.first;
  bool isTextTapSelected = true;
  String selectedDay = '';

  final List<Map<String, String>> movies = [
    {
      "title": "Movies 1",
      "date": "14 june, 2024",
      "poster": "https://upload.wikimedia.org/wikipedia/en/b/be/Godzilla_x_kong_the_new_empire_poster.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "date": "14 june, 2024",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "date": "14 june, 2024",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "date": "14 june, 2024",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "date": "14 june, 2024",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
  ];
  final dateInfo = DateInfo();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      user.fetchUserController();
    });
    selectedDay = dateInfo.dates.first;
    _pageController = PageController(viewportFraction: 0.85);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
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
    _timer.cancel();
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
        title: const TextWidget('Legend Cinema', size: 22, bold: true,),
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
      body: _buildBody(),
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
                      image: AssetImage(_currentImagePath),
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
                          DotIndicatorWidget(currentPage: _currentPage, itemCount: images.length), 
                          const Gap(12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(12),
            _buildTabView(),
            _buildTimeLine(),
            _buildTimeLineItems(),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterInput(){
    return Container(
      padding: const EdgeInsets.all(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                'All',
                size: 16,
              ),
              Icon(
                Icons.arrow_drop_down_circle_outlined,
              ),
            ],
          ),
        ),
      ),
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
          _currentImagePath = images[index]; 
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
            _currentPage = index;
            _currentImagePath = images[index]; 
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
                        isNowShowing = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isNowShowing ? Colors.red : Colors.grey.shade600,
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
                        isNowShowing = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isNowShowing ? Colors.grey.shade600 : Colors.red,
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
             // change body
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeLineItems() {
      return Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 2 / 3,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movies[index]['poster']!,
                    width: 200,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(10),
                Row(
                  children: [
                    TextWidget(
                      movies[index]['date']!,
                      size: 12,
                    ),
                    const Gap(5),
                    Stack(
                      children: [
                        Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white
                          ),
                        ),
                        const Positioned(
                          top: 1,
                          left: 10,
                          child: TextWidget('TBC', size: 12, bold: true, color: Colors.black,),
                        )
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    movies[index]['title']!,
                    bold: true,
                    size: 14,
                  ),
                ),
            
              ],
            );
          },
        ),
      );
    }
  }

class DateInfo {
  final now = DateTime.now();

  List<String> get daysOfWeek {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) {
      if (date.isAtSameMomentAs(now)) {
        return 'Today, ${DateFormat('MMM d').format(date)}';
      } else {
        return DateFormat('EEE, MMM d').format(date);
      }
    }).toList();
  }

  List<String> get dayNames {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) {
      if (date.day == now.day && date.month == now.month && date.year == now.year) {
        return 'Today';
      } else {
        return DateFormat('EEE').format(date);
      }
    }).toList();
  }

  List<String> get months {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) => DateFormat('MMM').format(date)).toList();
  }

  List<String> get dates {
    final days = List.generate(4, (i) => now.add(Duration(days: i)));
    return days.map((date) => DateFormat('d').format(date)).toList();
  }
}
