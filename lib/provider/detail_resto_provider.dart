import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestoProvider extends ChangeNotifier {
  final ApiService apiService;
  String restaurantId;

  DetailRestoProvider({required this.apiService, required this.restaurantId}) {
    _fetchDetailRestaurant();
  }

  late RestaurantsDetail _restaurantsDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantsDetail get result => _restaurantsDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailResto(restaurantId);
      if (restaurant.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsDetail = restaurant;
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
