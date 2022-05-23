import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/shared/component/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context,title: 'Add Post',),
    );
  }
}
