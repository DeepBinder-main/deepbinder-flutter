// import 'dart:js';

// import 'package:quizz/home/home.dart';
// import 'package:quizz/topics/topics.dart';
// import 'package:quizz/about/about.dart';
// import 'dart:js';
// import 'package:deepbinder/routes/page.dart';
import 'package:deepbinder/routes/about.dart';
import 'package:deepbinder/routes/create_group.dart';
import 'package:deepbinder/routes/create_single_user.dart';
import 'package:deepbinder/routes/home.dart';
import 'package:deepbinder/routes/login.dart';
import 'package:deepbinder/routes/simple_dialog_box.dart';
import 'package:deepbinder/routes/users.dart';
import 'routes/profile.dart';
// import 'package:quizz/quizz/quizz.dart';
// import 'package:quizz/profile/profile.dart';
// import 'realtime/realtime.dart';

var appRoutes = {
  // '/': (context) => HomeScreen(),
  '/login': (context) => LoginWidget(),
  '/home': (context) => MyApp(),
  '/users': (context) => Users(),
  '/createGroup': (context) => CreateGroupDialog(),
  '/createUser': (context) => CreateUserDialog(),
  // '/page': (context) => Page1(),
  // '/topics': (context) => TopicsScreen(),
  '/profile': (context) => Profile(),
  // '/about': (context) => AboutScreen(),
  // '/realtime': (context) => RealScreen(title: 'Realtime')
};
