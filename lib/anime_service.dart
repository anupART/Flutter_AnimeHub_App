import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model_class.dart';

class AnimeService {
  final String apiUrl = "https://api.jikan.moe/v4/top/anime?type=movie";

  Future<ModelClass> getAnimeList() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {

        final data = json.decode(response.body);
        return ModelClass.fromJson(data);
      } else {
        throw Exception('Failed to load anime data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
