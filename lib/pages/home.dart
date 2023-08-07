import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/blocs/videos_blocs.dart';
import 'package:youtube_app/delegates/data_search.dart';
import 'package:youtube_app/widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('images/youtube.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              '0',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSeacrh());
              if (result != null) {
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: ((context, index) {
                return VideoTile(snapshot.data[index]);
              }),
              itemCount: snapshot.data.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
