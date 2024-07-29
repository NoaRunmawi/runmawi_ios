class RentalMovieModel {
  bool? status;
  String? message;
  List<RentalMovieData>? data;

  RentalMovieModel({this.status, this.message, this.data});

  RentalMovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RentalMovieData>[];
      json['data'].forEach((v) {
        data!.add(new RentalMovieData.fromJson(v));
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

class RentalMovieData {
  String? orderId;
  String? videoTitle;
  String? createdAt;
  String? validTill;
  String? categoryName;

  RentalMovieData(
      {this.orderId,
        this.videoTitle,
        this.createdAt,
        this.validTill,
        this.categoryName});

  RentalMovieData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    videoTitle = json['video_title'];
    createdAt = json['created_at'];
    validTill = json['valid_till'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['video_title'] = this.videoTitle;
    data['created_at'] = this.createdAt;
    data['valid_till'] = this.validTill;
    data['category_name'] = this.categoryName;
    return data;
  }
}