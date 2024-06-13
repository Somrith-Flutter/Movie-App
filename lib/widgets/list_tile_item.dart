import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:legend_cinema/widgets/text_widget.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    this.data,
    this.widget,
    this.onTap,
  });

  final List<ListTileItem>? data;
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
            item!.isSpacig ? const Gap(8) : const Gap(0),
            if(item.isheader == true)
              Align(
                alignment: Alignment.topLeft,
                child: TextWidget(item.header)
              ),
            ListTile(
              title: TextWidget(item.title),
              leading: item.isAssetIcon == true 
                ? SizedBox(
                    height: 40,
                    width: 30,
                    child: Image.asset(item.assetIcon!)
                  ) : Icon(item.icon),
              trailing: item.trailing ? const Icon(Icons.chevron_right) : const Text(''),
              onTap: () => onTap != null ? onTap!(index) : '',
              hoverColor: Colors.white.withOpacity(0.3),
            ),
          ],
        );
      }
    );
  }
}

class ListTileItem {
  const ListTileItem({
    this.title,
    this.icon,
    this.onTap,
    this.trailing = false,
    this.header,
    this.route,
    this.assetIcon,
    this.isSpacig = false,
    this.isheader = false,
    this.isAssetIcon = false,
  });

  final String? title;
  final IconData? icon;
  final String? assetIcon;
  final bool isAssetIcon;
  final VoidCallback? onTap;
  final bool trailing;
  final String? header;
  final Widget? route;
  final bool isSpacig;
  final bool isheader;
}

class ListTileWidget extends StatelessWidget{
  const ListTileWidget({
    super.key,
    this.title,
    this.icon,
    this.onTap,
    this.trailing = false,
    this.header,
    this.route,
    this.isSpacig = false,
  });

  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool trailing;
  final String? header;
  final Widget? route;
  final bool isSpacig;

  @override 
  Widget build(BuildContext context){
    return Column(
      children: [
        isSpacig ? const Gap(8) : const Gap(0),
        Align(
        alignment: Alignment.topLeft,
        child: TextWidget(header)),
        ListTile(
          title: TextWidget(title),
          leading: Icon(icon),
          trailing: trailing ? const Icon(Icons.chevron_right) : const Text(''),
          hoverColor: Colors.blue.withOpacity(0.9),
          onTap: onTap,
        ),
      ],
    );
  }
}

