import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryCircle extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final bool isMyStory;

  const StoryCircle({
    Key? key,
    required this.imageUrl,
    required this.userName,
    this.isMyStory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isMyStory ? Colors.blue : Colors.grey,
                  width: 3.0,
                ),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            if (isMyStory)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          userName,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
