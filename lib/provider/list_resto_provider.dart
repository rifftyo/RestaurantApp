import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';

enum ResultState { loading, noData, hasData, error }

class ListRestoProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestoProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantsList _restaurantsList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantsList get result => _restaurantsList;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getListResto();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsList = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      if (e.toString().contains('ClientException')) {
        return _message = 'No Internet Connection';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }
}
