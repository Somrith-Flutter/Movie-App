import 'package:flutter/material.dart';
import 'package:legend_cinema/modules/landings/more/widgets/list_tile_item.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTileItem(
                icon: Icons.flag,
                title: 'Khmer',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTileItem(
                icon: Icons.flaky,
                title: 'English',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTileItem(
                icon: Icons.flashlight_off,
                title: 'Chinese',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget('Purchase',),
              const ListTileItem(
                title: 'Purchase',
                icon: Icons.currency_pound,
                trailing: true,
              ),
              const TextWidget('Languages'),
              ListTileItem(
                title: 'English',
                icon: Icons.language,
                trailing: true,
                onTap: () => _showLanguageDialog(context),
              ),
              const TextWidget('Account'),
              const ListTileItem(
                title: 'Change password',
                icon: Icons.password,
                trailing: true,
              ),
              const TextWidget("What's new ?"),
              const ListTileItem(
                title: 'News Activity',
                icon: Icons.local_activity,
                trailing: true,
              ),
              const TextWidget('Notifications'),
              const ListTileItem(
                title: 'Notifications',
                icon: Icons.notifications,
                trailing: true,
              ),
              const TextWidget('About us'),
              const ListTileItem(
                title: 'About us',
                icon: Icons.info_outline_rounded,
                trailing: true,
              ),
              const ListTileItem(
                title: 'Contact us',
                icon: Icons.call,
                trailing: true,
              ),
              const ListTileItem(
                title: 'Privacy Policy',
                icon: Icons.policy,
                trailing: true,
              ),
              const ListTileItem(
                title: 'Team and Conditions',
                icon: Icons.person_2,
                trailing: true,
              ),
              const ListTileItem(
                title: 'Logout',
                icon: Icons.logout,
                trailing: true,
              ),
            ],
          ),
      ),
    );
  }
}