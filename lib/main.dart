import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/modules/shop_login/social_login_screen.dart';
import 'package:social_app/shared/bloc_provider.dart';
import 'package:social_app/shared/component/constants.dart';
import 'package:social_app/shared/network/local/cach_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/social_layout_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CachHelper.init();
  uId = CachHelper.getData(key: 'uId');
  // print(uId);
  Widget widget;
  if(uId != null) widget = SocialLayoutScreen();
  else widget = SocialLoginScreen();

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: widget,
    );
  }
}


