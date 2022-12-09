import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'album.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({Key? key}) : super(key: key);

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {

  late Future<List<Album>> albums;

  @override
  void initState() {
    albums = getAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
      ),
      body: FutureBuilder<List<Album>>(
        builder: (context, snapshot) {
          return renderAlbums(snapshot);
        },
        future: albums
      ),
    );
  }

  Widget renderAlbums(AsyncSnapshot<List<Album>> snapshot) {
    if (snapshot.hasData) {
      return ListView(
        children: snapshot.data!.map((element) =>
            Row(
              children: [
                Text(element.id.toString()),
                Text(element.userId.toString()),
                Text(element.title),
              ],
            )
        ).toList()
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return const CircularProgressIndicator();
  }

  final url = "https://jsonplaceholder.typicode.com/albums";
  Future<List<Album>> getAlbums() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var tempList = (jsonDecode(response.body) as List<dynamic>).map((e) => e as Map<String, dynamic>);
      var albumList = tempList.map((e) => Album.fromJson(e)).toList();
      return albumList;
    } else {
      throw Exception('Failed to load album');
    }

  }
}

