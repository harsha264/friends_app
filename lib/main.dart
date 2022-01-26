import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friends_app/view/homescreen.dart';
import 'package:friends_app/view/login.dart';
import 'package:friends_app/view/register.dart';
import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? sharedPreferences;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Montserrat'
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const Login(),
        '/register': (BuildContext context) => const Register(),
        '/home': (BuildContext context) => const HomeScreen(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    sharedPreferences = await SharedPreferences.getInstance();
    
    if (sharedPreferences?.getString('userLoggedIn') == null || sharedPreferences?.getString('userLoggedIn') == "") {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 220.0, bottom: 50.0, right: 0.0, left: 0.0),
              child: SvgPicture.asset("assets/friends_icon.svg"),
            ),
          ),
        ],
      ),
    );
  }
}
