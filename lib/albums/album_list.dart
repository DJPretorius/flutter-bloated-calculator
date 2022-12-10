import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'album.dart';
import 'album_row.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({Key? key}) : super(key: key);

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {

  late Stream<Album>albumStream;
  late Future<Album> album;

  List<Album> _albums = [];

  @override
  void initState() {
    album = getAlbum();
    albumStream = streamAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: Text(
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                    "Album ID"
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      "User ID"
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      "Title"
                  ),
                ),
              ],
            ),
            FutureBuilder<Album>(
              builder: (context, snapshot) {
                return renderAlbum(snapshot);
              },
              future: album
            ),
            StreamBuilder<Album>(
              builder: (context, snapshot) {
                return renderAlbumStream(snapshot);
              },
              stream: albumStream,
            )
          ],
        ),
      ),
    );
  }

  Widget renderAlbumStream(AsyncSnapshot<Album> snapshot) {
    if (snapshot.hasData) {
      _albums.add(snapshot.data!);
      return Expanded(
        child: ListView(
          children: _albums.map((e) => AlbumRow(album: e)).toList(),
        ),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return const CircularProgressIndicator();
  }

  Widget renderAlbum(AsyncSnapshot<Album> snapshot) {
    if (snapshot.hasData) {
      return AlbumRow(album: snapshot.data!);
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return const CircularProgressIndicator();
  }

  final url = "https://jsonplaceholder.typicode.com/albums/";
  Future<Album> getAlbum() async {
    var response = await http.get(Uri.parse("$url/1"));

    if (response.statusCode == 200) {
      var jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      var album = Album.fromJson(jsonMap);
      return album;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Stream<Album> streamAlbums() async* {
    var futureList = <Future>[];
    for (int i = 2; i <=12; i++) {
      var request = http.get(Uri.parse("$url/$i"));
      futureList.add(request);
    }

    for (final future in futureList) {
      var response = await future;

      if (response.statusCode == 200) {
        var jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
        var album = Album.fromJson(jsonMap);
        await Future.delayed(const Duration(seconds: 2));
        yield album;
      } else {
        throw Exception('Failed to load album');
      }
    }
  }
}



