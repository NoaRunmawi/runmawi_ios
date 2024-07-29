class HomeModel {
  bool? status;
  String? message;
  List<Data>? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? categoryName;
  List<ShowList>? showList;

  Data({this.categoryName, this.showList});

  Data.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    if (json['show_list'] != null) {
      showList = <ShowList>[];
      json['show_list'].forEach((v) {
        showList!.add(new ShowList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    if (this.showList != null) {
      data['show_list'] = this.showList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowList {
  var id;
  String? title;
  String? description;
  String? casting;
  String? director;
  String? producer;
  String? releaseYear;
  var showCategory;
  String? genre;
  var ppvValidity;
  var ppvCost;
  var rentOption;
  var message;
  String? urlMain;
  var urlTrailer;
  var premierOn;
  var originalVideo;
  var category;
  var tvshowId;
  var urlDrm;
  var drmKey;
  var urlChrome;
  var vdocipherId;
  var vimeoId;
  var url;
  var img;
  var trailerUrl;
  var summary;
  var directUrl;
  var videoId;

  ShowList(
      {this.id,
        this.title,
        this.description,
        this.casting,
        this.director,
        this.producer,
        this.releaseYear,
        this.showCategory,
        this.genre,
        this.ppvValidity,
        this.ppvCost,
        this.rentOption,
        this.message,
        this.urlMain,
        this.urlTrailer,
        this.premierOn,
        this.originalVideo,
        this.category,
        this.tvshowId,
        this.urlDrm,
        this.drmKey,
        this.urlChrome,
        this.vdocipherId,
        this.vimeoId,
        this.url,
        this.img,
        this.trailerUrl,
        this.summary,
        this.directUrl,
        this.videoId});

  ShowList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    casting = json['casting'];
    director = json['director'];
    producer = json['producer'];
    releaseYear = json['release_year'];
    showCategory = json['show_category '];
    genre = json['genre'];
    ppvValidity = json['ppv_validity'];
    ppvCost = json['ppv_cost'];
    rentOption = json['rent_option'];
    message = json['message'];
    urlMain = json['url_main'];
    urlTrailer = json['url_trailer'];
    premierOn = json['premier_on'];
    originalVideo = json['original_video'];
    category = json['category'];
    tvshowId = json['tvshow_id'];
    urlDrm = json['url_drm'];
    drmKey = json['drm_key'];
    urlChrome = json['url_chrome'];
    vdocipherId = json['vdocipher_id'];
    vimeoId = json['vimeo_id'];
    url = json['url'];
    img = json['img'];
    trailerUrl = json['trailer_url'];
    summary = json['summary'];
    directUrl = json['direct_url'];
    videoId = json['video_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['casting'] = this.casting;
    data['director'] = this.director;
    data['producer'] = this.producer;
    data['release_year'] = this.releaseYear;
    data['show_category '] = this.showCategory;
    data['genre'] = this.genre;
    data['ppv_validity'] = this.ppvValidity;
    data['ppv_cost'] = this.ppvCost;
    data['rent_option'] = this.rentOption;
    data['message'] = this.message;
    data['url_main'] = this.urlMain;
    data['url_trailer'] = this.urlTrailer;
    data['premier_on'] = this.premierOn;
    data['original_video'] = this.originalVideo;
    data['category'] = this.category;
    data['tvshow_id'] = this.tvshowId;
    data['url_drm'] = this.urlDrm;
    data['drm_key'] = this.drmKey;
    data['url_chrome'] = this.urlChrome;
    data['vdocipher_id'] = this.vdocipherId;
    data['vimeo_id'] = this.vimeoId;
    data['url'] = this.url;
    data['img'] = this.img;
    data['trailer_url'] = this.trailerUrl;
    data['summary'] = this.summary;
    data['direct_url'] = this.directUrl;
    data['video_id'] = this.videoId;
    return data;
  }
}