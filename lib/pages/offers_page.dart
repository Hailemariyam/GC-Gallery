import 'package:flutter/material.dart';
import 'package:gc_gallery/pages/webview_page.dart';
import 'package:get/get.dart';
import '../utils/mock_data.dart';

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Offers'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: mockOffers.length,
        itemBuilder: (context, index) {
          final offer = mockOffers[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // Navigate to WebViewPage using GetX and pass the offer link
                Get.to(
                  () => const WebViewPage(),
                  arguments: offer.link, // Pass the offer link as argument
                );
              },
              child: Column(
                children: [
                  Image.asset(offer.imageUrl, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      offer.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      offer.description,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
