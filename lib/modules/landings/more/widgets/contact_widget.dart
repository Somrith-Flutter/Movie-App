import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/config/routes/app_route.dart';
import 'package:legend_cinema/config/themes/app_color.dart';
import 'package:legend_cinema/constants/app_constant.dart';
import 'package:legend_cinema/translation/generated/l10n.dart';
import 'package:legend_cinema/widgets/back_widget.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        title: TextWidget(
          S.of(context).contact_us,
          size: 22,
          bold: true,
        ),
        flexibleSpace: AppConstant.appbarTheme,
      ),
      backgroundColor: AppColor.primaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context){
    return ContactListTile(
      data: items(context),
      onTap: (index) {
        if (index >= 0 && index < items(context).length) {
          var selectedItem = items(context)[index];
          if (selectedItem.route != null) {
            AppRoute().push(context, selectedItem.route!);
          } else {
            const SizedBox();
          }
        }
      }
    );
  }
}

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    super.key,
    this.data,
    this.widget,
    this.onTap,
  });

  final List<ContactItem>? data;
  final Widget? widget;
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data?.length,
      itemBuilder: (context, index) {
        var item = data?[index];
        return Column(
          children: [
            item!.isSpacig ? const Gap(12) : const Gap(0),
            if(item.isheader == true)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextWidget(item.header, bold: true,),
                )
              ),
            item.isSpacig ? const Gap(12) : const Gap(0),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.3)), 
                  bottom: BorderSide(color: Colors.white.withOpacity(0.3))
                ),
                color: Theme.of(context).cardColor
              ),
              child: ListTile(
                title: TextWidget(item.title),
                // ignore: unrelated_type_equality_checks
                leading: item.iconAsset == true
                  ? SizedBox(
                      height: 40,
                      width: 30,
                      child: Image.asset(item.iconAsset!)
                    ) : Icon(item.icon),
                onTap: () => onTap != null ? onTap!(index) : '',
                hoverColor: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        );
      }
    );
  }
}

class ContactItem{
  ContactItem({
    this.title,
    this.icon,
    this.iconAsset,
    this.header,
    this.isheader = false,
    this.isSpacig = false,
    this.isAssetIcon = false,
    this.route,
  });

  final String? title;
  final IconData? icon;
  final String? iconAsset;
  final String? header;
  final bool isheader;
  final bool isSpacig;
  final bool isAssetIcon;
  final Widget? route;
}

List<ContactItem> items(BuildContext context)  {
  return [
    ContactItem(
      title: '089826667',
      isAssetIcon: false,
      icon: Icons.call,
      route: const Text(''),
      header: 'Contact Info',
      isheader: true,
      isSpacig: true
    ),
    ContactItem(
      title: 'Messanger',
      isAssetIcon: false,
      route: const Text(''),
      icon: Icons.message,   
      isSpacig: false
    ),
    ContactItem(
      title: 'info@legend.com.kh',
      isAssetIcon: false,
      route: const Text(''),
      icon: Icons.movie,
      isSpacig: false
    ),

    ContactItem(
      title: '087 888 045 / 087 888 048',
      isAssetIcon: false,
      route: const Text(''),
      icon: Icons.phone,
      header: 'Advertising & Partnership',
      isheader: true,
      isSpacig: true
    ),
    ContactItem(
      title: 'marketing@legend.com.kh',
      isAssetIcon: false,
      icon: Icons.sell, 
     isSpacig: false,
    ),
  ];
}