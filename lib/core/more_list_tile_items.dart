import 'package:flutter/material.dart';
import 'package:legend_cinema/modules/landings/more/widgets/about_us.dart';
import 'package:legend_cinema/modules/landings/more/widgets/contact_widget.dart';
import 'package:legend_cinema/modules/landings/more/widgets/language_widget.dart';
import 'package:legend_cinema/modules/landings/more/widgets/news_widget.dart';
import 'package:legend_cinema/modules/landings/more/widgets/notification_widget.dart';
import 'package:legend_cinema/modules/landings/more/widgets/privacy_policy.dart';
import 'package:legend_cinema/modules/landings/more/widgets/term_condition.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/list_tile_item.dart';

List<ListTileItem> items(BuildContext context, String title, String icon)  {
  return [
    // const TextWidget(
    //   'Purchase',
    // ),
    // const ListTileItem(
    //   title: 'Purchase',
    //   icon: Icons.currency_pound,
    //   trailing: true,
    //),
    // language

    ListTileItem(
      title: title,
      isAssetIcon: true,
      assetIcon: icon,
      icon: Icons.language,
      trailing: true,
      route: const LanguageWidget(),
      header: S.of(context).language,
      isheader: true,
      isSpacig: true
    ),
    // const TextWidget('Account'),
    // const ListTileItem(
    //   title: 'Change password',
    //   icon: Icons.password,
    //   trailing: true,
    // ),
    ListTileItem(
      title:  S.of(context).news_activity,
      icon: Icons.local_activity,
      trailing: true,
      isSpacig: true,
      route: const NewsWidget(),
      header: S.of(context).what_new,
      isheader: true
    ),
    ListTileItem(
      title: S.of(context).notification,
      icon: Icons.notifications,
      trailing: true,
      header: S.of(context).notification,
      isheader: true,
      isSpacig: true,
      route: const NotificationWidget()
    ),
    ListTileItem(
      title: S.of(context).about_us,
      icon: Icons.info_outline_rounded,
      trailing: true,
      isSpacig: true,
      header: S.of(context).about_us,
      isheader: true,
      route: const AboutUsWidget(),
    ),
    ListTileItem(
      title: S.of(context).contact_us,
      icon: Icons.call,
      trailing: true,
      route: const ContactWidget(),
    ),
    ListTileItem(
      title: S.of(context).privacy_policy,
      icon: Icons.policy,
      trailing: true,
      route: const PrivacyPolicyWidget()
    ),
    ListTileItem(
      title: S.of(context).term_condition,
      icon: Icons.person_2,
      trailing: true,
      route: const TermConditionWidget()
    ),
    // const ListTileItem(
    //   title: 'Logout',
    //   icon: Icons.logout,
    //   trailing: true,
    // ),
  ];
}