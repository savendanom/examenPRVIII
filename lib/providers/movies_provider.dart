import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_movies/models/models.dart';
import 'dart:convert';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'dc78a2c62445f9916c561515ba5d8413';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Cast> castMovies = [];
  List<Cast> teamMovies = [];
  List<SimilarMovie> similarsMovies = [];
  List<TopRatedMovie> topRatedMovies = [];
  List<ReviewsMovie> listReviewsMovies = [];

  String request_token = '';
  String guest_session_id = '';
  String session_id = '';

  MoviesProvider() {
    print('Provider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();

    // Autenticación para enviar una calificación
    this.getSessionAuth();
    // this.getTokenAuth();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(this._baseUrl, '3/movie/now_playing',
        {'api_key': this._apiKey, 'language': this._language, 'page': '1'});

    final response = await http.get(url);
    final nowPlatingResponse = NowPlayingResponse.fromJson(response.body);

    this.onDisplayMovies = nowPlatingResponse.results;

    // Se detecta un cambio, se vuelven a crear los widgets
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(this._baseUrl, '3/movie/popular',
        {'api_key': this._apiKey, 'language': this._language, 'page': '1'});

    final response = await http.get(url);
    final pupularResponse = PopularResponse.fromJson(response.body);

    this.popularMovies = [...popularMovies, ...pupularResponse.results];

    // Se detecta un cambio, se vuelven a crear los widgets
    notifyListeners();
  }

  Future<List> getPepolMovie(int idMovie) async {
    var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/credits',
        {'api_key': this._apiKey, 'language': this._language, 'page': '1'});

    final response = await http.get(url);
    final pepolResponse = PepolResponse.fromJson(response.body);

    this.castMovies = pepolResponse.cast;
    this.teamMovies = pepolResponse.crew;

    return [castMovies, teamMovies];
  }

  Future<List<SimilarMovie>> getsimilarMovies(int idMovie) async {
    var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/similar',
        {'api_key': this._apiKey, 'language': this._language, 'page': '1'});

    final response = await http.get(url);
    final similarResponse = SimilarResponse.fromJson(response.body);

    this.similarsMovies = similarResponse.results;

    return similarsMovies;
  }

  Future<List<ReviewsMovie>> getReviewsMovies(int idMovie) async {
    var url = Uri.https(
        this._baseUrl, '3/movie/${idMovie}/reviews', {'api_key': this._apiKey});

    final response = await http.get(url);
    final reviewsResponse = ReviewsResponse.fromJson(response.body);

    this.listReviewsMovies = reviewsResponse.results;

    return listReviewsMovies;
  }

  getTopRatedMovies() async {
    var url = Uri.https(this._baseUrl, '3/movie/top_rated',
        {'api_key': this._apiKey, 'language': this._language, 'page': '1'});

    final response = await http.get(url);
    final topRatedResponse = TopratedResponse.fromJson(response.body);

    this.topRatedMovies = topRatedResponse.results;

    // Se detecta un cambio, se vuelven a crear los widgets
    notifyListeners();
  }

  // TODO: Segundo metodo de Auth
  getTokenAuth() async {
    var url = Uri.https(this._baseUrl, '3/authentication/token/new', {
      'api_key': this._apiKey,
    });

    final responseAuth = await http.get(url);
    final tokenResponse = TokenResponse.fromJson(responseAuth.body);

    request_token = tokenResponse.requestToken;

    print('Token: ${request_token}');

    sendTokenSession('7d062874f71c4c85e6bccff55434dfd7ef5666a0');
  }

  getSessionAuth() async {
    var url = Uri.https(this._baseUrl, '3/authentication/guest_session/new', {
      'api_key': this._apiKey,
    });

    final responseAuth = await http.get(url);
    final sessionAuthResponse =
        GuestSessionResponse.fromJson(responseAuth.body);

    guest_session_id = sessionAuthResponse.guestSessionId;

    print('Guest Session: ${guest_session_id}');
  }

  // TODO: Segundo metodo de session para rating
  sendTokenSession(String token) async {
    var url = Uri.https(this._baseUrl, '3/authentication/session/new', {
      'api_key': this._apiKey,
    });

    Map<String, String> headers = {'Content-Type': 'application/json'};
    final jsonToken = jsonEncode({"request_token": token});

    final responseSession =
        await http.post(url, headers: headers, body: jsonToken);
    final sessionResponse = SessionResponse.fromJson(responseSession.body);

    if (sessionResponse.success) {
      print('SESSION: ${sessionResponse.sessionId}');
      this.session_id = sessionResponse.sessionId!;
    } else {
      print('Error: ${sessionResponse}');
    }
  }

  // var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/rating', {'api_key': this._apiKey, 'session_id': this.session_id});
  sendRated(int idMovie, double valueRated) async {
    var url = Uri.https(this._baseUrl, '3/movie/${idMovie}/rating',
        {'api_key': this._apiKey, 'guest_session_id': this.guest_session_id});

    Map<String, String> headers = {'Content-Type': 'application/json'};
    final jsonRating = jsonEncode({"value": valueRated});

    final responseRating =
        await http.post(url, headers: headers, body: jsonRating);
    final ratingResponse = RatingResponse.fromJson(responseRating.body);

    print('POST: ${ratingResponse.success}');
    print('POST Message: ${ratingResponse.statusMessage}');

    return ratingResponse.statusMessage;
  }

  Future<List> getLogos(int id) async {
    var url = Uri.https(this._baseUrl, '3/company/${id}/images', {
      'api_key': this._apiKey,
    });

    final response = await http.get(url);
    final infoResponse = LogosResponse.fromJson(response.body);

    return infoResponse.logos;
  }

  Future<CompanyResponse> getInfoCompany(int idCompany) async {
    var url = Uri.https(this._baseUrl, '3/company/${idCompany}', {
      'api_key': this._apiKey,
    });

    final response = await http.get(url);
    final companyResponse = CompanyResponse.fromJson(response.body);

    return companyResponse;
  }
}
