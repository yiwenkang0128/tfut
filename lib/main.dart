import 'package:flutter/material.dart';
import 'package:i_budget/pages/create_page.dart';
import 'package:i_budget/pages/login_page.dart';
import 'package:i_budget/pages/profile_page.dart';
import 'package:i_budget/pages/register_page.dart';
import 'pages/home_page.dart';
import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper.instance.deleteDatabaseFile();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iBudget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case '/register':
            return MaterialPageRoute(
                builder: (context) => const RegisterPage());
          case '/home':
            return MaterialPageRoute(
              builder: (context) {
                final args = settings.arguments as Map<String, dynamic>?;
                final userId = args?['userId'];
                if (userId == null || userId.isEmpty) {
                  // Redirect to login if userId is not available
                  return const LoginPage();
                }
                return HomePage(userId: userId);
              },
            );
          case '/create':
            return MaterialPageRoute(
              builder: (context) {
                final args = settings.arguments as Map<String, dynamic>?;
                final userId = args?['userId'];
                if (userId == null || userId.isEmpty) {
                  // Redirect to login if userId is not available
                  return const LoginPage();
                }
                return CreatePage(userId: userId);
              },
            );
          case '/profile':
            return MaterialPageRoute(
              builder: (context) {
                final args = settings.arguments as Map<String, dynamic>?;
                final userId = args?['userId'];
                if (userId == null || userId.isEmpty) {
                  // Redirect to login if userId is not available
                  return const LoginPage();
                }
                return ProfilePage(userId: userId);
              },
            );
          default:
            return MaterialPageRoute(builder: (context) => const LoginPage());
        }
      },
    );
  }
}
