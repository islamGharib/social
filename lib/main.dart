import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/modules/shop_login/social_login_screen.dart';
import 'package:social_app/shared/bloc_provider.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
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


