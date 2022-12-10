import 'package:flutter/material.dart';

import 'album.dart';

class AlbumRow extends StatelessWidget {
  const AlbumRow({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(album.id.toString()),
          ),
          Expanded(
            flex: 1,
            child: Text(album.userId.toString())
          ),
          Expanded(
            flex: 2,
            child: Text(album.title)
          ),
        ],
      ),
    );
  }
}