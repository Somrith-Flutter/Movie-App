import 'package:flutter/material.dart';
import 'package:legend_cinema/modules/landings/cinema/view/cinema_page.dart';
import 'package:legend_cinema/modules/landings/f_b/view/f_b_page.dart';
import 'package:legend_cinema/modules/landings/home/view/home_page.dart';
import 'package:legend_cinema/modules/landings/more/view/more_page.dart';
import 'package:legend_cinema/modules/landings/offers/view/offers_page.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const HomePage(),
    const OffersPage(),
    const CinemaPage(),
    const FBPage(),
    const MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: _selectPage,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _selectPage,
        type: BottomNavigationBarType.fixed, 
        backgroundColor: const Color.fromARGB(255, 26, 25, 25).withOpacity(0.9),
        items: [
          _buildNavItem(Icons.home_outlined, S.of(context).home, _currentPageIndex == 0),
          _buildNavItem(Icons.local_offer_outlined, S.of(context).offer, _currentPageIndex == 1),
          _buildNavItem(Icons.location_pin, S.of(context).cinema, _currentPageIndex == 2),
          _buildNavItem(Icons.food_bank_outlined, S.of(context).fb, _currentPageIndex == 3),
          _buildNavItem(Icons.crop, S.of(context).more, _currentPageIndex == 4),
        ],
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Container(
        height: 30,
        width: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade900 : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          shape: BoxShape.rectangle,
        ),
        child: Icon(icon, color: isSelected ? Colors.white : Colors.white.withOpacity(0.5)),
      ),
      label: label,
    );
  }
}
