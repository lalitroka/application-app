import 'package:firstdemo/auth/login_page.dart';
import 'package:firstdemo/pages/dashboard.dart';
import 'package:firstdemo/pages/leave_request_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/dashboardpage',
      routes: {
        '/loginpage': (context) => const LoginPage(),
        '/leaverequestpage': (context) => const LeaveRequestPage(),
        '/dashboardpage': (context) => const Dashboard(),
      },
    );
  }
}
