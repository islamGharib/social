import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/modules/shop_login/social_login_screen.dart';
import 'package:social_app/shared/styles/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SocialLoginScreen(),
    );
  }
}


