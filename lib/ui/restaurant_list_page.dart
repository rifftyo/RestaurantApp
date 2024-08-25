import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/list_resto_provider.dart';
import 'package:restaurant_app/provider/search_resto_provider.dart';
import 'package:restaurant_app/widget/card_restaurant.dart';
import 'package:restaurant_app/widget/card_search_restaurant.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list_page';

  const RestaurantListPage({super.key});

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ListRestoProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) =>
                SearchRestoProvider(apiService: ApiService(), value: query))
      ],
      child: Scaffold(
        backgroundColor: Colors.green[50],
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: const Text(
                  'Restaurant',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 13.0),
                child: const Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Recomendation restaurant for you!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              // TextField untuk pencarian
              Container(
                margin: const EdgeInsets.all(13.0),
                child: Consumer<SearchRestoProvider>(
                  builder: (context, provider, _) {
                    return TextField(
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                        provider.fetchSearchRestaurant(query);
                      },
                      decoration: InputDecoration(
                          hintText: 'Search Restaurant',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search)),
                    );
                  },
                ),
              ),
              Expanded(
                child: query.isEmpty
                    ? _buildList(context)
                    : _buildSearchList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<ListRestoProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              color: Colors.green[50],
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _buildSearchList(BuildContext context) {
    return Consumer<SearchRestoProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateSearch.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultStateSearch.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardSearchRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultStateSearch.noData) {
          return Center(
            child: Material(
              color: Colors.green[50],
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          );
        } else if (state.state == ResultStateSearch.error) {
          return Center(
            child: Material(
              color: Colors.green[50],
              child: Text(
                state.message,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }
}
