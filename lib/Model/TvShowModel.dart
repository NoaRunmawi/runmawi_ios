class TVShowModel {
  bool? status;
  String? message;
  List<TVShowData>? data;

  TVShowModel({this.status, this.message, this.data});

  factory TVShowModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<TVShowData> tvShowDataList =
    dataList.map((e) => TVShowData.fromJson(e)).toList();

    return TVShowModel(
      status: json['status'],
      message: json['message'],
      data: tvShowDataList,
    );
  }
}

class TVShowData {
  String? id;
  String? title;
  String? description;
  String? director;
  String? producer;
  String? length;
  String? casting;
  String? rentOption;
  String? img;
  String? category;
  String? releaseYear;
  String? trailerUrl;
  String? genre;
  String? ppvCost;
  String? ppvValidity;
  String? premierDate;
  String? premierOn;
  String? html;
  var  averageRating;
  var userRating;
  String? userSaveMovie;
  String? validTill;
  String? type;
  var urlDrm;
   var directUrl;
  List<EpisodeDetails>? episodeDetails;
  TVShowData({
     this.id,
     this.title,
     this.description,
     this.director,
     this.producer,
     this.length,
     this.casting,
     this.rentOption,
     this.img,
     this.category,
     this.releaseYear,
     this.trailerUrl,
     this.genre,
     this.ppvCost,
     this.ppvValidity,
     this.premierDate,
     this.premierOn,
     this.html,
     this.averageRating,
     this.userRating,
     this.userSaveMovie,
     this.validTill,
     this.type,
     this.urlDrm,
     this.directUrl,
     this.episodeDetails,
  });

  factory TVShowData.fromJson(Map<String, dynamic> json) {

    var episodeDetailsList = json['episode_details'] as List;
    List<EpisodeDetails> episodeDetailsListData =
    episodeDetailsList.map((e) => EpisodeDetails.fromJson(e)).toList();

    return TVShowData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      director: json['director'],
      producer: json['producer'],
      length: json['length'],
      casting: json['casting'],
      rentOption: json['rent_option'],
      img: json['img'],
      category: json['category'],
      releaseYear: json['release_year'],
      trailerUrl: json['trailer_url'],
      genre: json['genre'],
      ppvCost: json['ppv_cost'],
      ppvValidity: json['ppv_validity'],
      premierDate: json['premier_date'],
      premierOn: json['premier_on'],
      html: json['html'],
      averageRating: json['average_rating'],
      userRating: json['user_rating'],
      userSaveMovie: json['user_save_movie'],
      validTill: json['valid_till'],
      type: json['type'],
      urlDrm: json['url_drm'],
      directUrl: json['direct_url'],
      episodeDetails: episodeDetailsListData,
    );
  }
}

class EpisodeDetails {
  String? id;
  String? tvShowId;
  var coconut_movie_url;
  String? videoImage;
  String? title;
  String? length;
  String? ppvCost;
  String? ppvValidity;
  String? episodeValidTill;

  EpisodeDetails({
     this.id,
     this.tvShowId,
     this.videoImage,
     this.title,
     this.length,
     this.ppvCost,
     this.ppvValidity,
     this.episodeValidTill,
    this.coconut_movie_url,
  });

  factory EpisodeDetails.fromJson(Map<String, dynamic> json) {
    return EpisodeDetails(
      id: json['id'],
      tvShowId: json['tv_show_id'],
      videoImage: json['video_image'],
      title: json['title'],
      length: json['length'],
      ppvCost: json['ppv_cost'],
      ppvValidity: json['ppv_validity'],
      episodeValidTill: json['episode_valid_till'],
      coconut_movie_url: json['coconut_movie_url'],
    );
  }
}
