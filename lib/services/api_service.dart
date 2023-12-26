import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  final String popular = "popular";

  void getMovies() async {
    try {
      final url = Uri.parse("$baseUrl/$popular");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // print(response.body);
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> movies = responseBody['results'];
        for (var movie in movies) {
          print(movie);
        }
        return;
      }
    } catch (error) {
      print("Error during API call: $error");
    }
  }
}
