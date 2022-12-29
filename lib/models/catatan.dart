class CatatanModel {
  late int id;
  late String judul;
  late String deskripsi;
  late int waktu_pengingat;
  late int interval_pengingat;
  late String lampiran;

  CatatanModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.waktu_pengingat,
    required this.interval_pengingat,
    required this.lampiran,
  });

  CatatanModel.fromMap(Map<String, Object?> first);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['deskripsi'] = deskripsi;
    data['waktu_pengingat'] = waktu_pengingat;

    data['interval_pengingat'] = interval_pengingat;
    data['lampiran'] = lampiran;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'waktu_pengingat': waktu_pengingat,
      'interval_pengingat': interval_pengingat,
      'lampiran': lampiran,
    };
  }

  CatatanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    waktu_pengingat = json['waktu_pengingat'];
    interval_pengingat = json['interval_pengingat'];
    lampiran = json['lampiran'];
  }
}
