class BankSoal {
  String? message;
  Data? data;

  BankSoal({this.message, this.data});

  BankSoal.fromJson(Map<String, dynamic> json) {
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
  String? pertanyaan;
  String? opsiA;
  String? opsiB;
  String? opsiC;
  String? opsiD;
  String? jawabanBenar;
  int? idKategoriSoal;
  int? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.pertanyaan,
      this.opsiA,
      this.opsiB,
      this.opsiC,
      this.opsiD,
      this.jawabanBenar,
      this.idKategoriSoal,
      this.createdBy,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    pertanyaan = json['pertanyaan'];
    opsiA = json['opsi_a'];
    opsiB = json['opsi_b'];
    opsiC = json['opsi_c'];
    opsiD = json['opsi_d'];
    jawabanBenar = json['jawaban_benar'];
    idKategoriSoal = json['id_kategori_soal'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  get deskripsi => null;

  get judul => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pertanyaan'] = this.pertanyaan;
    data['opsi_a'] = this.opsiA;
    data['opsi_b'] = this.opsiB;
    data['opsi_c'] = this.opsiC;
    data['opsi_d'] = this.opsiD;
    data['jawaban_benar'] = this.jawabanBenar;
    data['id_kategori_soal'] = this.idKategoriSoal;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
