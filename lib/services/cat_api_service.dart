import 'dart:convert';
import 'package:catflip/models/cat.dart';
import 'package:http/http.dart' as http;

class CatApiService {
  static const String _apiKey = '9cc40953-6e51-43dc-a397-b5ff40f60715';

  http.Client _client;

  CatApiService() {
    _client = new http.Client();
  }

  Future<List<Cat>> fetchCats(
      {int limit = 10, String order = 'ASC', int page = 0}) async {
    const String _url = 'https://api.thecatapi.com/v1/images/search?';
    const String _mimeTypes = 'jpg,png';

    final response = await _client.get(
      '${_url}limit=$limit&order=$order&page=$page&mime_types=$_mimeTypes',
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      // OK
      List jsonResponse = json.decode(response.body);

      return List<Cat>.from(
          jsonResponse.map((cat) => new Cat.fromJsonSearch(cat)));
    } else {
      // Not OK
      throw Exception('Failed to fetch a cat');
    }
  }

  Future<List<Cat>> getFavourites() async {
    const url = 'https://api.thecatapi.com/v1/favourites';

    final response = await _client.get(
      url,
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      // OK
      List jsonResponse = json.decode(response.body);

      return List<Cat>.from(
          jsonResponse.map((cat) => new Cat.fromJsonFavourite(cat)));
    } else {
      // Not OK
      throw Exception('Failed to fetch a cat');
    }
  }

  Future<bool> addFavourite(String imageId) async {
    const url = 'https://api.thecatapi.com/v1/favourites';

    final response = await _client.post(
      url,
      headers: {'x-api-key': _apiKey, 'Content-Type': 'application/json'},
      body: '{"image_id":"$imageId"}',
    );

    return response.statusCode == 200;
  }

  Future<bool> removeFavourite(String imageId) async {
    const url = 'https://api.thecatapi.com/v1/favourites/:';

    final response = await _client.delete(
      '$url$imageId',
      headers: {'x-api-key': _apiKey},
    );

    return response.statusCode == 200;
  }

  void dispose() {
    _client.close();
  }
}
