import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/api.dart';
import 'package:youtube_app/blocs/videos_blocs.dart';
import 'package:youtube_app/pages/home.dart';

void main() {
  Api api = Api();
  api.search('eletro');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      dependencies: const [],
      blocs: [Bloc((i) => VideosBloc())],
      child: MaterialApp(
        title: 'FlutterTube',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
