import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vigoplace/core/providers/user.dart';
import 'package:vigoplace/screens/posts.dart';
import 'package:vigoplace/screens/sign_up.dart';
import 'package:vigoplace/screens/dashboard_container.dart';
import 'package:vigoplace/screens/sign_in.dart';
import 'package:vigoplace/screens/personal_info.dart';

import 'core/custom_route.dart';
// import 'core/services/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await UserSharedPreferences.init();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vigoplace',
        theme: ThemeData(
          fontFamily: 'Poppins',
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder()
          }),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return SignUp();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SignIn();
          },
        ),
        routes: {
          SignUp.routeName: (context) => SignUp(),
          SignIn.routeName: (context) => SignIn(),
          PersonalInfo.routeName: (context) => PersonalInfo(),
          Home.routeName: (context) => Home(),
          PostScreen.routeName: (context) => const PostScreen(),
        },
      ),
    );
  }
}
