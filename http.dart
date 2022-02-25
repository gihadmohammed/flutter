import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:gihad/model/model.dart';
import 'package:http/http.dart' as http;

class Httphelper {
  static Future<List<movie>> getUpcoming() async {
    const String upcome =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=2699115b03930e90a8fce543668a7a4c&language=en-US';
    var response = await http.get(Uri.parse(upcome));
    if (response.statusCode == HttpStatus.ok) {
      final jsonresponse = jsonDecode(response.body);
      final movieObject = jsonresponse['results'];
      List<movie> movies = movieObject.map((e) => movie.fromJson(e));
      return movies;
    } else {
      return [];
    }
  }

  static Future<List<movie>> getUfavorite() async {
    const String favorite =
        "https://api.themoviedb.org/3/movie/popular?api_key=2699115b03930e90a8fce543668a7a4c&language=en-US";
    var response = await http.get(Uri.parse(favorite));
    if (response.statusCode == HttpStatus.ok) {
      final jsonresponse = jsonDecode(response.body);
      final movieObject = jsonresponse['results'];
      List<movie> movies = movieObject.map((e) => movie.fromJson(e));

      return movies;
    } else {
      return [];
    }
  }

  static Future<List<movie>> find(String title) async {
    const String urlsearch =
        'https://api.themoviedb.org/3/search/movie?api_key=2699115b03930e90a8fce543668a7a4c&query=';
    final String query = urlsearch + title;
    final result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      final jsonresponse = jsonDecode(result.body);
      final moviemap = jsonresponse['results'];
      List<movie> movies =
          List<movie>.from(moviemap.map((i) => movie.fromJson(i)));
      return movies;
    } else {
      return [];
    }
  }

  static Future<List<movie>> getLatest() async {
    final String url =
        "https://api.themoviedb.org/3/movie/popular?api_key=2699115b03930e90a8fce543668a7a4c&language=en-US";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final moviesMap = jsonResponse['results'];
      List<movie> moviesLatest =
          List<movie>.from(moviesMap.map((i) => movie.fromJson(i)));
     
      return moviesLatest;
    } else {
      return [];
    }
  }
}
