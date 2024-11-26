import 'DienThoai.dart';

class Hoadon {
  String _maHoaDon;
  DateTime _ngayBan;
  DienThoai _dienThoaiBanDuoc;
  int _soLuongMua;
  double _giaBanThucTe;
  String _tenKhachHang;
  String _soDienThoai;

  Hoadon(
      this._maHoaDon,
      this._ngayBan,
      this._dienThoaiBanDuoc,
      this._giaBanThucTe,
      this._soDienThoai,
      this._soLuongMua,
      this._tenKhachHang);

  String get maHoaDon => _maHoaDon;
  DateTime get ngayBan => _ngayBan;
  DienThoai get dienThoaiBanDuoc => _dienThoaiBanDuoc;
  int get soLuongMua => _soLuongMua;
  double get giaBanThucTe => _giaBanThucTe;
  String get tenKhachHang => _tenKhachHang;
  String get soDienThoai => _soDienThoai;

  set maHoaDon(String maHoaDon) {
    if (maHoaDon.isNotEmpty && RegExp(r'^HD-\d{3}$').hasMatch(maHoaDon)) {
      _maHoaDon = maHoaDon;
    }
  }

  set ngayBan(DateTime ngayBan) {
    if (ngayBan.isAfter(DateTime.now())) {
      _ngayBan = ngayBan;
    }
  }

  set dienThoaiBanDuoc(DienThoai dienThoaiBanDuoc) {
    _dienThoaiBanDuoc = dienThoaiBanDuoc;
  }

  set soLuongMua(int soLuongMua) {
    if (soLuongMua > 0 && soLuongMua <= dienThoaiBanDuoc.soLuongKhoTon) {
      _soLuongMua = soLuongMua;
    }
  }

  set tenKhachHang(String tenKhachHanh) {
    if (tenKhachHanh.isNotEmpty) {
      _tenKhachHang = tenKhachHanh;
    }
  }

  set soDienThoai(String soDienThoai) {
    if (soDienThoai.isNotEmpty && RegExp(r'^\d+$').hasMatch(soDienThoai)) {
      _soDienThoai = soDienThoai;
    }
  }

  //Tong tien
  double tongTien() {
    return soLuongMua * giaBanThucTe;
  }

  //Loi nhuan
  double loiNhuan() {
    return tongTien() - dienThoaiBanDuoc.giaNhap * soLuongMua;
  }

  //Hien thi hoa don
  void hienThiHoaDon() {
    print('Ma hoa don: $_maHoaDon');
    print('Ngay ban: $_ngayBan');
    print('Tong tien: ${tongTien()}');
    print('So luong: $_soLuongMua');
    print('Ten khach hang: $_tenKhachHang');
    print('So dien thoai: $_soDienThoai');
  }
}
