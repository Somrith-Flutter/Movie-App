import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    this.title,
    this.icon,
  });

  final String? title;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title!),
      onTap: () => {},
      trailing: const Icon(Icons.chevron_right),
    );
  }
}