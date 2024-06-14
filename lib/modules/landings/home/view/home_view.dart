import 'dart:async';
import 'package:flutter/material.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/asset_path.dart';

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
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController _pageController;
  late Timer _timer;
  bool isNowShowing = true;
  int selectedIndex = 0;
  final List<String> dates = ["14 Jun", "15 Jun", "16 Jun"];
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 20), (Timer timer) {
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Legend Cinema'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColor.appbarColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  hintText: "Search cinema...",
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white70.withOpacity(0.1),
                ),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 250,
                height: 350, // Constrain the height
                child: Card(
                  color: Colors.white70,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 100,
                        color: selectedIndex == index ? Colors.red : Colors.black,
                        child: Center(
                          child: Text(
                            dates[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true, // Important to use shrinkWrap here
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.book_online_sharp,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}
