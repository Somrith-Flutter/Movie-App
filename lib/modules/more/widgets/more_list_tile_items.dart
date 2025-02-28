import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/modules/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/more/developer_settings/about.dart';
import 'package:legend_cinema/modules/more/developer_settings/news.dart';
import 'package:legend_cinema/modules/more/developer_settings/offers.dart';
import 'package:legend_cinema/modules/more/widgets/about_us.dart';
import 'package:legend_cinema/modules/more/widgets/contact_widget.dart';
import 'package:legend_cinema/modules/more/widgets/developer_mode.dart';
import 'package:legend_cinema/modules/more/widgets/language_widget.dart';
import 'package:legend_cinema/modules/more/widgets/news_widget.dart';
import 'package:legend_cinema/modules/more/widgets/notification_widget.dart';
import 'package:legend_cinema/modules/more/widgets/privacy_policy.dart';
import 'package:legend_cinema/modules/more/widgets/purchase_widget.dart';
import 'package:legend_cinema/modules/more/widgets/term_condition.dart';
import 'package:legend_cinema/shared/v_globle.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/list_tile_item.dart';

MoreController controller = Get.find();
List<ListTileItem> items(BuildContext context, String title, String icon)  {
  return [
    if (accessToken.$.isNotEmpty)...[
      ListTileItem(
        title: S.of(context).purchase,
        icon: Icons.currency_pound,
        trailing: true,
        route: const PurchaseWidget(),
        header: S.of(context).purchase,
        isheader: true,
        isSpacig: true,
        isRoute: true,
      ),
    ],
    ListTileItem(
      title: title,
      isAssetIcon: true,
      assetIcon: icon,
      icon: Icons.language,
      trailing: true,
      route: const LanguageWidget(),
      header: S.of(context).language,
      isheader: true,
      isSpacig: true,
      isRoute: true
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
      isheader: true,
      isRoute: true
    ),
    ListTileItem(
      title: S.of(context).notification,
      icon: Icons.notifications,
      trailing: true,
      header: S.of(context).notification,
      isheader: true,
      isSpacig: true,
      route: const NotificationWidget(),
      isRoute: true
    ),
    ListTileItem(
      title: S.of(context).about_us,
      icon: Icons.info_outline_rounded,
      trailing: true,
      isSpacig: true,
      header: S.of(context).about_us,
      isheader: true,
      route: const AboutUsWidget(),
      isRoute: true
    ),
    ListTileItem(
      title: S.of(context).contact_us,
      icon: Icons.call,
      trailing: true,
      route: const ContactWidget(),
      isRoute: true
    ),
    ListTileItem(
      title: S.of(context).privacy_policy,
      icon: Icons.policy,
      trailing: true,
      route: const PrivacyPolicyWidget(),
      isRoute: true,
    ),
    ListTileItem(
      title: S.of(context).term_condition,
      icon: Icons.person_2,
      trailing: true,
      route: const TermConditionWidget(),
      isRoute: true
    ),
    if(controller.isDeveloperModeEnabled.value)...[
      ListTileItem(
        title: S.of(context).developer_mode,
        icon: Icons.developer_mode,
        isSpacig: true,
        trailing: true,
        isheader: true,
        header: S.of(context).developer_mode,
        route: const DeveloperMode(),
        isRoute: true,
      )
    ],
    if(accessToken.$.isNotEmpty)...[
      ListTileItem(
        title: S.of(context).logout,
        icon: Icons.logout,
        isSpacig: true,
        trailing: true,
        isRoute: false,
        isheader: true,
        header: S.of(context).logout,
      ),
    ]
  ];
}

List<ListTileItem> developerItem(BuildContext context){
  return [
    const ListTileItem(
      header: 'News & Activity',
      title: 'Get | Post | Delete',
      icon: Icons.newspaper,
      trailing: true,
      isSpacig: true,
      isheader: true,
      isRoute: true,
      route: News(),
    ),
    const ListTileItem(
      header: 'Aboutus',
      title: 'Get | Post | Delete',
      icon: Icons.app_settings_alt,
      trailing: true,
      isSpacig: true,
      isheader: true,
      isRoute: true,
      route: Aboutus()
    ),
    const ListTileItem(
      header: 'Offers',
      title: 'Get | Post | Delete',
      icon: Icons.local_offer_outlined,
      trailing: true,
      isSpacig: true,
      isheader: true,
      isRoute: true,
      route: Offers(),
    ),
  ];
}