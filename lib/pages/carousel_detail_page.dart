import 'package:flutter/material.dart';
import 'package:gc_gallery/models/carousel_item.dart';

class DetailPage extends StatelessWidget {
  final CarouselItem carouselItem;

  const DetailPage({Key? key, required this.carouselItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carouselItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(carouselItem.image), // Displaying the image
            const SizedBox(height: 20),
            Text(
              carouselItem.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              carouselItem.description,
              style: const TextStyle(fontSize: 16),
            ),
            // Add more information or widgets as needed
          ],
        ),
      ),
    );
  }
}
