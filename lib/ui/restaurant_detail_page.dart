import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';
import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/provider/detail_resto_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final dynamic restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final restaurantId = (restaurant is RestaurantL)
        ? (restaurant as RestaurantL).id
        : (restaurant as RestaurantS).id;
        
    return ChangeNotifierProvider(
      create: (_) => DetailRestoProvider(
          apiService: ApiService(), 
          restaurantId: restaurantId
        ),
      child: Scaffold(
        body: _buildDetail(),
      ),
    );
  }

  Widget _buildDetail() {
    return Consumer<DetailRestoProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return Container(
          color: Colors.green[50],
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state.state == ResultState.hasData) {
        var detail = state.result.restaurant;
        return detailRestorant(context, detail);
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else if (state.state == ResultState.error) {
        return Scaffold(
          backgroundColor: Colors.green[50],
          body: Center(
              child: Material(
                color: Colors.green[50],
                child: Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
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
    });
  }

  Scaffold detailRestorant(BuildContext context, RestaurantD? detail) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      ApiService.imageUrl + restaurant.pictureId,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SafeArea(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 35,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      detail!.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                      ),
                      Text(
                        detail.rating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.pin_drop),
                  Text(
                    detail.city,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Description',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(detail.description,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Food Menu:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: detail.menus.foods.map((food) {
                    return Text(
                      '- ${food.name}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  }).toList()),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Drink Menu:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: detail.menus.drinks.map((drink) {
                    return Text(
                      '- ${drink.name}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  }).toList()),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
