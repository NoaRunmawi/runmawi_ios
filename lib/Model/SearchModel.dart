class SearchModel {
   String? id;
   String? img;
   String? type;
   String? movieName;
   String? duration;
   String? releaseYear;
   String? genre;

  SearchModel({
     this.id,
     this.img,
     this.type,
     this.movieName,
     this.duration,
     this.releaseYear,
     this.genre,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['video_id'] ?? '',
      img: json['img'] ?? '',
      type: json['type'] ?? '',
      movieName: json['movie_name'] ?? '',
      duration: json['duration'] ?? '',
      releaseYear: json['release_year'] ?? '',
      genre: json['genre'] ?? '',
    );
  }
}

class SearchResponse {
   bool? status;
   String? message;
   List<SearchModel>? data;

  SearchResponse({
     this.status,
     this.message,
     this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<SearchModel> dataList =
    list.map((i) => SearchModel.fromJson(i)).toList();

    return SearchResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: dataList,
    );
  }
}
