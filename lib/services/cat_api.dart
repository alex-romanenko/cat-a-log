import 'dart:convert';
import 'package:catflip/models/cat.dart';
import 'package:http/http.dart' as http;

class CatApi {
  static const String _apiKey = '9cc40953-6e51-43dc-a397-b5ff40f60715';
  static const String _url = 'https://api.thecatapi.com/v1/images/search?';
  static const String _mimeTypes = 'jpg,png';

  http.Client client;

  CatApi() {
    client = new http.Client();
  }

  Future<Cat> fetchCat() async {
    final response = await client.get(
      '$_url&mime_types=$_mimeTypes',
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      // OK
      return Cat.fromJson(json.decode(response.body)[0]);
    } else {
      // Not OK
      throw Exception('Failed to load cat');
    }
  }

  Future<List<Cat>> fetchCats(
      {int limit = 10, String order = 'ASC', int page = 0}) async {
    final response = await client.get(
      '${_url}limit=$limit&order=$order&page=$page&mime_types=$_mimeTypes',
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      // OK
      List jsonResponse = json.decode(response.body);

      return List<Cat>.from(jsonResponse.map((cat) => new Cat.fromJson(cat)));
    } else {
      // Not OK
      throw Exception('Failed to load cat');
    }
  }

  void dispose() {
    client.close();
  }
}
