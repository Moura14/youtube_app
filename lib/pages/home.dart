import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/blocs/favorite_bloc.dart';
import 'package:youtube_app/blocs/videos_blocs.dart';
import 'package:youtube_app/delegates/data_search.dart';
import 'package:youtube_app/models/video.dart';
import 'package:youtube_app/pages/favorites.dart';
import 'package:youtube_app/widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideosBloc>();
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('images/youtube.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text(
                      '${snapshot.data?.length}',
                      style: TextStyle(color: Colors.white),
                    );
                  else
                    return Container();
                },
              )),
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Favorites()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSeacrh());
              if (result != null) {
                bloc.inSearch.add(result);
              }
            },
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: bloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
