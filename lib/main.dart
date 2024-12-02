import 'package:flutter/material.dart';
import 'package:i_budget/pages/create_page.dart';
import 'package:i_budget/pages/login_page.dart';
import 'package:i_budget/pages/overview_page.dart';
import 'package:i_budget/pages/profile_page.dart';
import 'package:i_budget/pages/register_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '记账App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // 全局背景颜色设置为白色
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/create': (context) => CreatePage(),
        '/overview': (context) => OverviewPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
