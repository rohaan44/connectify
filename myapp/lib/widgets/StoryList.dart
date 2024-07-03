import 'package:flutter/material.dart';
import 'package:myapp/widgets/StoryWidget.dart';

class StoriesList extends StatelessWidget {
  final List<Map<String, dynamic>> stories;

  const StoriesList({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: StoryCircle(
              imageUrl: story['imageUrl'],
              userName: story['userName'],
              isMyStory: story['isMyStory'] == 'true',
            ),
          );
        },
      ),
    );
  }
}
