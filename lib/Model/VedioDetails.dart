class MovieModel {
  bool? status;
  String? message;
  List<MovieData>? data;

  MovieModel({ this.status,  this.message, this.data});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<MovieData>.from(json['data'].map((x) => MovieData.fromJson(x)))
          : null,
    );
  }
}

class MovieData {
  var id;
  String? title;
  String? description;
  String? director;
  String? producer;
  var length;
  String? img;
  var category;
  var releaseYear;
  String? trailerUrl;
  String? summary;
  String? genre;
  var ppvCost;
  var ppvCost_two;
  var ppvCost_three;
  var ppvValidity;
  String? premierDate;
  String? premierOn;
  var user_rating;
  var average_rating;
  String? html;
  var videoId;
  String? validTill;
  String? direct_url;
  var user_save_movie;
  var type;
  String? urlDrm;
  String? videoUrl;
  var coconut_movie_url;
  String? bunny_video_id;
  String? quality;
  String? super_user;

  MovieData({
    this.id,
    this.title,
    this.description,
    this.director,
    this.producer,
    this.length,
    this.img,
    this.category,
    this.releaseYear,
    this.trailerUrl,
    this.summary,
    this.direct_url,
    this.user_rating,
    this.coconut_movie_url,
    this.genre,
    this.ppvCost,
    this.ppvCost_two,
    this.ppvCost_three,
    this.ppvValidity,
    this.premierDate,
    this.premierOn,
    this.html,
    this.videoId,
    this.validTill,
    this.user_save_movie,
    this.type,
    this.urlDrm,
    this.videoUrl,
    this.average_rating,
    this.bunny_video_id,
    this.quality,
    this.super_user
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      director: json['director'] ?? '',
      producer: json['producer'] ?? '',
      user_rating: json['user_rating']??'0',
      length: json['length'] ?? '',
      img: json['img'] ?? '',
      category: json['category'] ?? 0,
      releaseYear: json['release_year'] ?? 0,
      trailerUrl: json['trailer_url'] ?? '',
      summary: json['summary'],
      genre: json['genre'] ?? '',
      user_save_movie: json['user_save_movie']??"0",
      ppvCost: json['ppv_cost']?? 0.0,
      ppvCost_two: json['ppv_cost_two']?? 0.0,
      ppvCost_three: json['ppv_cost_three']?? 0.0,
      ppvValidity: json['ppv_validity'] ?? 0,
      premierDate: json['premier_date'],
      premierOn: json['premier_on'] ?? '',
      average_rating: json['average_rating'],
      html: json['html'],
      direct_url: json['direct_url'],
      videoId: json['video_id'],
      validTill: json['valid_till']??"",
      type: json['type'] ?? '',
      urlDrm: json['url_drm'] ?? '',
      videoUrl: json['video_url'] ?? '',
      coconut_movie_url: json['coconut_movie_url'],
      bunny_video_id:json['bunny_video_id'] ?? '',
      quality:json['quality'],
      super_user:json['super_user'],
    );
  }
}