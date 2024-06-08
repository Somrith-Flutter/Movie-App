import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    this.title,
    this.icon,
    this.onTap,
    this.trailing = false,
  });

  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title!),
        onTap: onTap,
        trailing: trailing ? const Icon(Icons.chevron_right) : const Text(''),
      ),
    );
  }
}