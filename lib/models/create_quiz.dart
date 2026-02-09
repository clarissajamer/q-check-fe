class CreateQuiz {
  String? message;
  Data? data;

  CreateQuiz({this.message, this.data});

  CreateQuiz.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? judul;
  String? deskripsi;
  String? startTime;
  String? endTime;
  int? createdBy;
  bool? isArchived;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.judul,
      this.deskripsi,
      this.startTime,
      this.endTime,
      this.createdBy,
      this.isArchived,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdBy = json['created_by'];
    if (json['is_archived'] is int) {
      isArchived = json['is_archived'] == 1;
    } else {
      isArchived = json['is_archived'];
    }
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['created_by'] = this.createdBy;
    data['is_archived'] = this.isArchived;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
