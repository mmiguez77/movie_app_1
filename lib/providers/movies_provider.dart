import 'package:http/http.dart' as http;
import 'package:movie_app/models/credits_response.dart';
import 'package:movie_app/models/models.dart';


import 'package:flutter/widgets.dart';

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = "api.themoviedb.org";
  final String _apiKey = "7c338cc1845b4fa7caae796c81d00aaa";
  final String _language = "es-ES";

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _pageNumber = 0;

  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String>_getJsonData(String endpoint, [int page = 1]) async {

    var url = Uri.https(_baseUrl, endpoint, { 
      'api_key': _apiKey, 
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    final response = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(response);
    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();

  }

  getPopularMovies() async {

    _pageNumber++;

    final response = await _getJsonData('3/movie/popular', _pageNumber);
    final popularResponse = PopularResponse.fromJson(response);
    popularMovies = [ ...popularMovies, ...popularResponse.results ];

    notifyListeners();

  }


}

