class RestaurantsList {
    bool error;
    String message;
    int count;
    List<RestaurantL> restaurants;

    RestaurantsList({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    factory RestaurantsList.fromJson(Map<String, dynamic> json) => RestaurantsList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantL>.from(json["restaurants"].map((x) => RestaurantL.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantL {
    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    RestaurantL({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory RestaurantL.fromJson(Map<String, dynamic> json) => RestaurantL(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}