class TvKey {
  bool? status;
  String? message;
  String? htmlContent;
  String? tvKey;

  TvKey({this.status, this.message, this.htmlContent, this.tvKey});

  TvKey.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    htmlContent = json['html_content'];
    tvKey = json['tv_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['html_content'] = this.htmlContent;
    data['tv_key'] = this.tvKey;
    return data;
  }
}