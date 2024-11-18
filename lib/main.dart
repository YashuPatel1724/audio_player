import 'package:audio_player/provider/music_provider.dart';
import 'package:audio_player/views/home_page.dart';
import 'package:audio_player/views/music_palyer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MediaProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => MusicHomePage(),
          '/play' : (context) => MusicPlayerPage(),
        },
      ),
    );
  }
}
