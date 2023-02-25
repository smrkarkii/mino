import 'package:flutter/material.dart';
import 'package:kasarijaane/components/constants.dart';

class Newsfeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: kdarkpurple,
      ),
      body: ListView(
        children: <Widget>[
          _buildNewsItem(
            'Breaking News',
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi lobortis, est non tempor fermentum, nisl erat eleifend tellus, sit amet accumsan nibh nibh a elit. Suspendisse at mi in justo ultricies elementum.',
            'https://picsum.photos/100',
          ),
          _buildNewsItem(
            'Sports News',
            'Phasellus auctor semper magna vel laoreet. Vestibulum euismod nunc id nibh interdum sagittis. Duis euismod elementum ipsum quis faucibus. Curabitur placerat justo id risus interdum, ut molestie mauris ultricies. ',
            'https://picsum.photos/100',
          ),
          _buildNewsItem(
            'Tech News',
            'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In ac ultrices urna. Donec in placerat augue. Sed vel congue ex. Ut aliquet quam a bibendum egestas.',
            'https://picsum.photos/100',
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(String title, String content, String imageUrl) {
   return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(content),
            ],
          ),
        ),
        SizedBox(width: 16),
        Image.network(
          imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}
  
}
