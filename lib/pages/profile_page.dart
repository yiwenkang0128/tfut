import 'package:flutter/material.dart';
import 'package:i_budget/widgets/avatar_generator.dart';
import 'package:i_budget/widgets/profile_item.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "John Doe";
  String email = "john.doe@example.com";
  String password = "********";

  void _editField(String field, String initialValue, Function(String) onSave) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: field,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(194, 255, 184, 77),
        title: Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            generateAvatar('User'),
            SizedBox(height: 20),
            ProfileItem(
              icon: Icons.person,
              title: 'Username',
              value: username,
              onEdit: () {
                _editField('Username', username, (value) {
                  setState(() {
                    username = value;
                  });
                });
              },
            ),
            Divider(),
            ProfileItem(
              icon: Icons.email,
              title: 'Email',
              value: email,
              onEdit: () {
                _editField('Email', email, (value) {
                  setState(() {
                    email = value;
                  });
                });
              },
            ),
            Divider(),
            ProfileItem(
              icon: Icons.lock,
              title: 'Password',
              value: password,
              onEdit: () {
                _editField('Password', password, (value) {
                  setState(() {
                    password = value;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
