import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier{
  
  final String _apiKey = '9e00b809407dc56e68c8ae9f2699cbcd';
  final String _baseUrl= 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    print('MoviesProvider inicializado');
    getOnDisplayMovie();
    getPopularMovies();

  }

  Future <String> getJsonData(String endPoint, [int page = 1]) async{
    final url = Uri.https(_baseUrl, endPoint, {
      'api_Key': _apiKey,
      'language': _language,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovie() async{
    final jsonData = await getJsonData('3/movie/now_playing');

    final PopularResponse nowPlayingResponse = PopularResponse.fromMap(jsonData);

    onDisplayMovie=nowPlayingResponse.results;
    notifyListeners();
  }

  
  getPopularMovies() async{

    _popularPage++;
    final jsonData = await getJsonData('3/movie/popular', _popularPage);
    final popularResponse = json.decode(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.result];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async{
    if( movieCast.containsKey(movieId) ) return movieCast[movieId];
    
    final jsonData = await getJsonData('3/movie/$movieId/credits');
    final creditsResponse = json.decode(jsonData);

    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies( String query) async{
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_Key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchResponse = json.decode(response.body);

    return searchResponse.results;
  }
}