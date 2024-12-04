import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../widgets/avatar_generator.dart';
import '../widgets/profile_item.dart';

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({required this.userId, super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final UserService _userService = UserService();
  String username = '';
  String email = '';
  String password = '********'; // Mask password
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final user = await _userService.getUserById(widget.userId);

      if (user != null) {
        setState(() {
          username = user['username'] ?? '';
          email = user['email'] ?? '';
        });
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load user data')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _editField(String field, String initialValue, Function(String) onSave) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: field),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final value = controller.text;
              await _updateUserField(field, value);
              onSave(value);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateUserField(String field, String value) async {
    try {
      switch (field.toLowerCase()) {
        case 'username':
          await _userService.updateUser(widget.userId, username: value);
          break;
        case 'email':
          await _userService.updateUser(widget.userId, email: value);
          break;
        case 'password':
          await _userService.updateUser(widget.userId, password: value);
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      debugPrint('Error updating $field: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update $field')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(194, 255, 184, 77),
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  generateAvatar(username),
                  const SizedBox(height: 20),
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
                  const Divider(),
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
                  const Divider(),
                  ProfileItem(
                    icon: Icons.lock,
                    title: 'Password',
                    value: password,
                    onEdit: () {
                      _editField('Password', password, (value) {
                        setState(() {
                          password = "********"; // Always mask password
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
