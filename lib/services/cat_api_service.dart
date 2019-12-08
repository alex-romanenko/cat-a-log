import 'dart:convert';
import 'package:catflip/models/cat.dart';
import 'package:http/http.dart' as http;

class CatApiService {
  static const String _apiUrl = 'https://api.thecatapi.com/v1';
  static const String _apiKey = '9cc40953-6e51-43dc-a397-b5ff40f60715';

  http.Client _client;

  CatApiService() {
    _client = new http.Client();
  }

  // GET /images/search
  Future<List<Cat>> getCats(
      {int limit = 10,
      String order = 'ASC',
      int page = 0,
      mimeTypes = 'jpg,png'}) async {
    const String url = '$_apiUrl/images/search?';

    final response = await _client.get(
      '${url}limit=$limit&order=$order&page=$page&mime_types=$mimeTypes',
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      // OK
      List jsonResponse = json.decode(response.body);

      return List<Cat>.from(jsonResponse.map((cat) => Cat.fromJsonSearch(cat)));
    } else {
      // Not OK
      throw Exception('Failed to get cats.');
    }
  }

  // GET /favourites
  Future<List<Cat>> getFavourites() async {
    const url = '$_apiUrl/favourites';

    final response = await _client.get(
      url,
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      // OK
      List jsonResponse = json.decode(response.body);

      return List<Cat>.from(
          jsonResponse.map((cat) => Cat.fromJsonFavourite(cat)));
    } else {
      // Not OK
      throw Exception('Failed to get favourites.');
    }
  }

  // POST /favourites
  Future<bool> addFavourite(String imageId) async {
    const url = '$_apiUrl/favourites';

    final response = await _client.post(
      url,
      headers: {'x-api-key': _apiKey, 'Content-Type': 'application/json'},
      body: '{"image_id":"$imageId"}',
    );

    return response.statusCode == 200;
  }

  // DEL /favourites/:favourite_id
  Future<bool> removeFavourite(String imageId) async {
    const url = '$_apiUrl/favourites/';

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
