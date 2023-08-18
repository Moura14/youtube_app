class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id = '', this.title = '', this.thumb = '', this.channel = ''});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id'))
      return Video(
          id: json['id']['videoId'] as String? ?? '',
          title: json['snippet']['title'] as String? ?? '',
          thumb: json['snippet']['thumbnails']['high']['url'] as String? ?? '',
          channel: json['snippet']['channelTitle'] as String? ?? '');
    else
      return Video(
          id: json['videoId'] ?? '',
          title: json['title'] ?? '',
          thumb: json['thumb'] ?? '',
          channel: json['channel' ?? '']);
  }

  Map<String, dynamic> toJson() {
    return {'videoId': id, 'title': title, 'thumb': thumb, 'channel': channel};
  }
}
