import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/blocs/favorite_bloc.dart';
import 'package:youtube_app/models/video.dart';
import 'package:youtube_app/blocs/favorite_bloc.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  const VideoTile(this.video, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        video.title,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        video.channel,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                stream: bloc.outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return IconButton(
                      icon: Icon(snapshot.data!.containsKey(video.id)
                          ? Icons.star
                          : Icons.star_border),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: () {
                        bloc.toggleFavorito(video);
                      },
                    );
                  else
                    return CircularProgressIndicator();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
