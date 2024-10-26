import 'package:firebase_core/firebase_core.dart';
import 'package:firstdemo/auth/login_page.dart';
import 'package:firstdemo/bloc/profile_bloc.dart';
import 'package:firstdemo/pages/dashboard.dart';
import 'package:firstdemo/pages/leave_listing_page.dart';
import 'package:firstdemo/pages/leave_request_page.dart';
import 'package:firstdemo/pages/notification_page.dart';
import 'package:firstdemo/pages/photo.dart';
import 'package:firstdemo/pages/profile_page.dart';
import 'package:firstdemo/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp(
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
          '/notificationpage': (context) => const NotificationPage(),
          '/leavelistingpage': (context) => const LeaveListingPage(),
          '/profilepage': (context) => const ProfilePage(),
          '/settingpage': (context) => const SettingPage(),
          '/photopage': (context) => const PhotoPage(),
        },
      ),
    );
  }
}
