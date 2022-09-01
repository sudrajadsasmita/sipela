class AprovedModel {
  String? userId;
  String? namaBarang;
  String? emailUser;
  String? statusPengiriman;
  String? statusTransaksi;
  String? transactionId;

  AprovedModel({
    required this.userId,
    required this.namaBarang,
    required this.emailUser,
    required this.statusPengiriman,
    required this.statusTransaksi,
    required this.transactionId,
  });

  AprovedModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    namaBarang = json['nama_barang'];
    emailUser = json['email_user'];
    statusPengiriman = json['status_pengiriman'];
    statusTransaksi = json['status_transaksi'];
    transactionId = json['transaction_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['nama_barang'] = this.namaBarang;
    data['email_user'] = this.emailUser;
    data['status_pengiriman'] = this.statusPengiriman;
    data['status_transaksi'] = this.statusTransaksi;
    data['transactionId'] = this.transactionId;
    return data;
  }
}
