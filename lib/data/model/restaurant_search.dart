class RestaurantsSearch {
    bool error;
    int founded;
    List<RestaurantS> restaurants;

    RestaurantsSearch({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory RestaurantsSearch.fromJson(Map<String, dynamic> json) => RestaurantsSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantS>.from(json["restaurants"].map((x) => RestaurantS.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantS {
    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    RestaurantS({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory RestaurantS.fromJson(Map<String, dynamic> json) => RestaurantS(
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
