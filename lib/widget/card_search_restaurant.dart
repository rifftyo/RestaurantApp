import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_search.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class CardSearchRestaurant extends StatelessWidget {
  final RestaurantS restaurant;

  const CardSearchRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green[50],
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            ApiService.imageUrl + restaurant.pictureId,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
          ),
        ),
        title: Text(restaurant.name),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.pin_drop, size: 8),
                Text(restaurant.city),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.star, size: 8),
                Text(restaurant.rating.toString())
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: restaurant);
        },
      ),
    );
  }
}
