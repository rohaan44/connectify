import 'dart:developer';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchStories() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users');
      log('fetchStories response: ${response.statusCode}, ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Map<String, dynamic>> stories = data.map<Map<String, dynamic>>((dynamic user) {
          return {
            'imageUrl': 'https://picsum.photos/200', // Placeholder image URL
            'userName': user['name'] as String,
            'isMyStory': false, // Changed to boolean type for consistency
          };
        }).toList();
        return stories;
      } else {
        throw Exception('Failed to load stories');
      }
    } catch (e) {
      log('Error in fetchStories: $e');
      throw Exception('Failed to load stories: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      log('fetchPosts response: ${response.statusCode}, ${response.data}');

      if (response.statusCode == 200) {
        List<dynamic> posts = response.data;

        // Fetch images and combine with posts
        for (var post in posts) {
          post['imageUrl'] = await fetchImage();
        }

        return List<Map<String, dynamic>>.from(posts);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      log('Error in fetchPosts: $e');
      throw Exception('Failed to load posts: $e');
    }
  }

  Future<String> fetchImage() async {
    try {
      final response = await _dio.get('https://picsum.photos/200', options: Options(responseType: ResponseType.bytes));
      log('fetchImage response: ${response.statusCode}, ${response.realUri}');

      if (response.statusCode == 200) {
        return response.realUri.toString();
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      log('Error in fetchImage: $e');
      // Retry the request a few times before giving up
      for (int i = 0; i < 3; i++) {
        try {
          final retryResponse = await _dio.get('https://picsum.photos/200', options: Options(responseType: ResponseType.bytes));
          log('Retry fetchImage response: ${retryResponse.statusCode}, ${retryResponse.realUri}');

          if (retryResponse.statusCode == 200) {
            return retryResponse.realUri.toString();
          }
        } catch (retryError) {
          log('Retry error in fetchImage: $retryError');
        }
      }
      // Use a default image URL as a fallback
      return 'https://picsum.photos/id/237/200/200'; // A specific fallback image URL
    }
  }
}
