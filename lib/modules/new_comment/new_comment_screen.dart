import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/styles/icon_broken.dart';


class NewCommentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black.withOpacity(0),
    ));
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 20,
            bottom: 5,
            start: 5,
            end: 5
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0,),
                              child: Row(
                                children: [
                                  Icon(
                                    IconBroken.Heart,
                                    size: 16.0,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 5.0,),
                                  Text(
                                    '0',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){},
                          ),
                        ),
                        InkWell(
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5.0,),
                              Text(
                                'Like',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){

                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/flutter-social-app-c29f1.appspot.com/o/users%2Fimage_picker1230714668660727270.jpg?alt=media&token=32fad613-e0a5-42e8-bed9-087ca5ea6f0b'),
                              ),
                              SizedBox(width: 15.0,),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadiusDirectional.circular(10),
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Islam Gharib',
                                              style: Theme.of(context).textTheme.bodyText1,
                                              maxLines: 6,
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              'Hi everyone Hello World, I\'m Islam Ahmed Ibrahim Gharib, Iam 29 years old' ,
                                              style: Theme.of(context).textTheme.caption,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        top: 15.0,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.0),
                                          image: DecorationImage(
                                            image: NetworkImage('https://img.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg?t=st=1648470843~exp=1648471443~hmac=e627e64a2eec9d1abe3d9db23ecb082fc29cadb26da7ab313811130fb0bf4169&w=900'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
