import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onEdit;

  const ProfileItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: onEdit,
      ),
    );
  }
}
