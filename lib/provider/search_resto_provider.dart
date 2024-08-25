import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';

enum ResultStateSearch { loading, noData, hasData, error }

class SearchRestoProvider extends ChangeNotifier {
  final ApiService apiService;
  String value;

  SearchRestoProvider({required this.apiService, required this.value}) {
    fetchSearchRestaurant(value);
  }

  late RestaurantsSearch _restaurantsSearch;
  late ResultStateSearch _state;
  String _message = '';

  String get message => _message;

  RestaurantsSearch get result => _restaurantsSearch;

  ResultStateSearch get state => _state;

  Future<dynamic> fetchSearchRestaurant(String value) async {
    try {
      _state = ResultStateSearch.loading;
      notifyListeners();

      final restaurant = await apiService.getSearchResto(value);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultStateSearch.noData;
        return _message = 'Restaurant Not Found';
      } else {
        _state = ResultStateSearch.hasData;
        return _restaurantsSearch = restaurant;
      }
    } catch (e) {
      _state = ResultStateSearch.error;
      if (e.toString().contains('ClientException')) {
        return _message = 'No Internet Connection';
      } else {
        return _message = 'Error --> $e';
      }
    } finally {
      notifyListeners();
    }
  }
}
