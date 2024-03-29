// import 'package:firebase_core/firebase_core.dart';
import 'package:deepbinder/routes/session_modal.dart';
import 'package:deepbinder/theme.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:quizz/routes.dart';
// import 'package:quizz/services/services.dart';
// import 'package:deepbinder/routes/shared.dart';
import 'package:deepbinder/routes/home.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
// import 'package:quizz/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   // Initialize FlutterFire:
    //   future: _initialization,
    //   builder: (context, snapshot) {
    //     // Check for errors
    //     if (snapshot.hasError) {
    //       // Error screen
    //     }

    //     // Once complete, show your application
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return StreamProvider(
    //         create: (_) => FirestoreService().streamReport(),
    //         catchError: (_, err) => Report(),
    //         initialData: Report(),
    //         child: MaterialApp(
    //             debugShowCheckedModeBanner: true,
    //             routes: appRoutes,
    //             theme: appTheme),
    //       );
    //     }

    //     // Otherwise, show something whilst waiting for initialization to complete
    //     return const MaterialApp(home: LoadingScreen());
    //   },
    // );
    // add provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DeepBinder',
        theme: appTheme,
        home: const MainWidget(),
      ),
    );
  }
}
