// import 'dart:js';

// import 'package:quizz/home/home.dart';
// import 'package:quizz/topics/topics.dart';
// import 'package:quizz/about/about.dart';
// import 'dart:js';
import 'package:deepbinder/routes/page.dart';
import 'package:deepbinder/routes/home.dart';
import 'package:deepbinder/routes/login.dart';
// import 'package:quizz/quizz/quizz.dart';
// import 'package:quizz/profile/profile.dart';
// import 'realtime/realtime.dart';

var appRoutes = {
  // '/': (context) => HomeScreen(),
  '/login': (context) => LoginWidget(),
  '/home': (context) => MainWidget(),
  '/page': (context) => Page1(),
  // '/topics': (context) => TopicsScreen(),
  // '/profile': (context) => ProfileScreen(),
  // '/about': (context) => AboutScreen(),
  // '/realtime': (context) => RealScreen(title: 'Realtime')
};
