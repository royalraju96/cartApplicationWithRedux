class PostRequestModel {
  int page;
  int perPage;

  PostRequestModel({this.page, this.perPage});

  PostRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    return data;
  }
}
