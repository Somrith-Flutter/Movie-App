import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/modules/auth/view/auth_page.dart';
import 'package:legend_cinema/modules/landings/more/controller/more_controller.dart';
import 'package:legend_cinema/modules/landings/more/widgets/contact_widget.dart';
import 'package:legend_cinema/modules/landings/more/widgets/language_widget.dart';
import 'package:legend_cinema/modules/landings/more/widgets/list_tile_item.dart';
import 'package:legend_cinema/modules/landings/more/widgets/notification_widget.dart';
import 'package:legend_cinema/modules/news_and_activity/view/news_and_activity_page.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {

  @override
  Widget build(BuildContext context) {
    final MoreController languageController = Get.find();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget('Account'),
            const Gap(8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => AppRoute().push(context, const AuthPage()), 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),
                    child: TextWidget(
                      S.of(context).login,
                    )
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),
                    child: TextWidget(
                      S.of(context).register,
                    )
                  ),
                ),
              ],
            ),
            Card(
              margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextWidget(S.of(context).lengend_membership, size: 20,)),
                      const Gap(12),
                    TextWidget(S.of(context).dis_legend_membership, size: 12,),
                    const Gap(24),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        onPressed: (){}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: TextWidget(
                          S.of(context).learn_more,
                          size: 12,
                          bold: true,
                        ),
                      ),
                    ),
                    const Gap(8),
                  ],
                ),
              ),
            ),
            // const TextWidget(
            //   'Purchase',
            // ),
            // const ListTileItem(
            //   title: 'Purchase',
            //   icon: Icons.currency_pound,
            //   trailing: true,
            //),
            TextWidget(S.of(context).language),
            Obx(() {
              String title;
              switch (languageController.currentLocale.value.languageCode) {
                case AppConstant.km:
                  title = S.of(context).khmer;
                  break;
                case AppConstant.zh:
                  title = S.of(context).chinese;
                  break;
                case AppConstant.en:
                default:
                  title = S.of(context).english;
                  break;
              }
              return ListTileItem(
                title: title,
                icon: Icons.language,
                trailing: true,
                onTap: () => AppRoute().push(context, const LanguageWidget()),
              );
            }),
            // const TextWidget('Account'),
            // const ListTileItem(
            //   title: 'Change password',
            //   icon: Icons.password,
            //   trailing: true,
            // ),
            const Gap(8),
            TextWidget(S.of(context).what_new),
            ListTileItem(
              title: S.of(context).news_activity,
              icon: Icons.local_activity,
              trailing: true,
              onTap: () => AppRoute().push(context, const NewsAndActivityPage()),
            ),
            const Gap(8),
            TextWidget(S.of(context).notification),
            ListTileItem(
              title: S.of(context).notification,
              icon: Icons.notifications,
              trailing: true,
              onTap: () => AppRoute().push(context, const NotificationWidget()),
            ),
            const Gap(8),
            TextWidget(S.of(context).about_us),
            ListTileItem(
              title: S.of(context).about_us,
              icon: Icons.info_outline_rounded,
              trailing: true,
            ),
            ListTileItem(
              title: S.of(context).contact_us,
              icon: Icons.call,
              trailing: true,
              onTap: () => AppRoute().push(context, const ContactWidget()),
            ),
            ListTileItem(
              title: S.of(context).privacy_policy,
              icon: Icons.policy,
              trailing: true,
            ),
            ListTileItem(
              title: S.of(context).term_condition,
              icon: Icons.person_2,
              trailing: true,
            ),
            // const ListTileItem(
            //   title: 'Logout',
            //   icon: Icons.logout,
            //   trailing: true,
            // ),
          ],
        ),
      ),
    );
  }
}