import 'package:flutter/material.dart';
import 'package:gc_gallery/models/album.dart';


class PhotosPage extends StatelessWidget {
  final Album album;

  PhotosPage({required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: album.photos.length,
        itemBuilder: (context, index) {
          final photo = album.photos[index];
          return Column(
            children: [
              Expanded(
                child: Image.asset(
                  photo.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(photo.title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }
}
