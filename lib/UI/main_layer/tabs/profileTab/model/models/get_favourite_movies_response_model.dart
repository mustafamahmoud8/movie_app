import 'dart:convert';

GetFavouriteMoviesResponseModel getWatchListMoviesResponseModelFromJson(
        String str) =>
    GetFavouriteMoviesResponseModel.fromJson(json.decode(str));

String getWatchListMoviesResponseModelToJson(
        GetFavouriteMoviesResponseModel data) =>
    json.encode(data.toJson());

class GetFavouriteMoviesResponseModel {
  GetFavouriteMoviesResponseModel({
    this.message,
    this.data,
  });

  GetFavouriteMoviesResponseModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FavouriteMovie.fromJson(v));
      });
    }
  }

  String? message;
  List<FavouriteMovie>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

FavouriteMovie dataFromJson(String str) => FavouriteMovie.fromJson(json.decode(str));

String dataToJson(FavouriteMovie data) => json.encode(data.toJson());

class FavouriteMovie {
  FavouriteMovie({
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  FavouriteMovie.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = (json['rating'] as num?)?.toDouble();
    imageURL = json['imageURL'];
    year = json['year'];
  }

  String? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }
}
