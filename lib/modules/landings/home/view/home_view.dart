import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:legend_cinema/constants/asset_path.dart';
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
      "poster": "https://upload.wikimedia.org/wikipedia/en/b/be/Godzilla_x_kong_the_new_empire_poster.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
    {
      "title": "Movies 2",
      "poster": "https://www.ripefruitmedia.com.au/images_rfm/1223-130236796.jpg" // Replace with the actual URL or local path
    },
  ];
  final dateInfo = DateInfo();

  @override
  void initState() {
    super.initState();
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isNowShowing = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isNowShowing ? Colors.red : Colors.grey,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: const Text(
                    'Now Showing',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isNowShowing = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isNowShowing ? Colors.grey : Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: const Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeLine() {
    return Align(
      alignment: Alignment.topLeft,
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
    );
  }

  Widget _buildTimeLineItems(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  movies[index]['poster']!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Text(
                  movies[index]['title']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
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
