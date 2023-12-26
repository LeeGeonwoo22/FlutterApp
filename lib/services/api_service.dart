import 'dart:convert';

import 'package:flutter_movie/models/movies_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  final String popular = "popular";

  Future<List<MoviesModel>> getMovies() async {
    try {
      List<MoviesModel> movieInstances = [];
      final url = Uri.parse("$baseUrl/$popular");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.body);
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> movies = responseBody['results'];
        for (var movie in movies) {
          final video = MoviesModel.fromJson(movie);
          // print(video.title);
          movieInstances.add(video);
        }
        return movieInstances;
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
        throw Exception("Failed to load data");
        // print("Response body: ${response.body}");
      }
    } catch (error) {
      print("Error during API call: $error");
      throw Exception("Error during API call");
    }
  }
}
