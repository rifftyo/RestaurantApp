import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String imageUrl = '${_baseUrl}images/large/';

  Future<RestaurantsList> getListResto() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list Restaurants');
    }
  }

  Future<RestaurantsDetail> getDetailResto(String idResto) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$idResto"));
    if (response.statusCode == 200) {
      return RestaurantsDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }

  Future<RestaurantsSearch> getSearchResto(String value) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$value"));
    if (response.statusCode == 200) {
      return RestaurantsSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search Restaurant');
    }
  }
}
