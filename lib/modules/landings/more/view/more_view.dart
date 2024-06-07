import 'package:flutter/material.dart';
import 'package:legend_cinema/modules/landings/more/widgets/list_tile_item.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget('Purchase',),
              ListTileItem(
                title: 'Purchase',
                icon: Icons.currency_pound,
              ),
              TextWidget('Languages'),
              ListTileItem(
                title: 'English',
                icon: Icons.language,
              ),
              TextWidget('Account'),
              ListTileItem(
                title: 'Change password',
                icon: Icons.password,
              ),
              TextWidget("What's new ?"),
              ListTileItem(
                title: 'News Activity',
                icon: Icons.local_activity,
              ),
              TextWidget('Notifications'),
              ListTileItem(
                title: 'Notifications',
                icon: Icons.notifications,
              ),
              TextWidget('About us'),
              ListTileItem(
                title: 'About us',
                icon: Icons.info_outline_rounded,
              ),
              ListTileItem(
                title: 'Contact us',
                icon: Icons.call,
              ),
              ListTileItem(
                title: 'Privacy Policy',
                icon: Icons.policy,
              ),
              ListTileItem(
                title: 'Team and Conditions',
                icon: Icons.person_2,
              ),
              ListTileItem(
                title: 'Logout',
                icon: Icons.logout,
              ),
            ],
          ),
      ),
    );
  }
}