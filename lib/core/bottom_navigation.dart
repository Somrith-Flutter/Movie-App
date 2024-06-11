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
  int currentPageIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> pages = const [
    HomePage(),
    OffersPage(),
    CinemaPage(),
    FBPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, S.of(context).home),
            _buildNavItem(1, Icons.local_offer_outlined, S.of(context).offer),
            _buildNavItem(2, Icons.location_pin, S.of(context).cinema),
            _buildNavItem(3, Icons.food_bank_outlined, S.of(context).fb),
            _buildNavItem(4, Icons.crop, S.of(context).more)
          ],
        ),
      ),
      body: pages[currentPageIndex],
    );
  }

  void _selectPage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

Widget _buildNavItem(int index, IconData icon, String label) {
  return InkWell(
    onTap: () {
      _selectPage(index);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: index == currentPageIndex ? Colors.blue : Colors.grey),
        Text(label, style: TextStyle(color: index == currentPageIndex ? Colors.blue : Colors.grey)),
      ],
    ),
  );
}
}
