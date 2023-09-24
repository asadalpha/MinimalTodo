import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/Firebase/fire_auth_methods.dart';
import 'package:taskapp/UI/Screens/login_page.dart';
import 'package:taskapp/firebase_options.dart';
import 'UI/Screens/homepage.dart';
import 'UI/Screens/landingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const LandingPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = const HomePage();
      });
    } else {
      currentPage = const LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: currentPage,
    );
  }
}
