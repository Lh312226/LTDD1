class DienThoai {
  String _maDienThoai;
  String _tenDienThoai;
  String _hangSX;
  double _giaNhap;
  double _giaBan;
  int _soLuongKhoTon;
  bool _trangThai;

  DienThoai(this._maDienThoai, this._tenDienThoai, this._hangSX, this._giaNhap,
      this._giaBan, this._soLuongKhoTon, this._trangThai);
  String get maDienThoai => _maDienThoai;
  String get tenDienThoai => _tenDienThoai;
  String get hangSX => _hangSX;
  double get giaNhap => _giaNhap;
  double get giaBan => _giaBan;
  int get soLuongKhoTon => _soLuongKhoTon;
  bool get trangThai => _trangThai;

  set maDienThoai(String maDienThoai) {
    if (maDienThoai.isNotEmpty && RegExp(r'^DT-\d{3}$').hasMatch(maDienThoai)) {
      //Kiem tra ma dien thoai dung voi dinh dang 'DT-XXX'
      _maDienThoai = maDienThoai;
    }
  }

  set tenDienThoai(String tenDienThoai) {
    if (tenDienThoai.isNotEmpty) {
      _tenDienThoai = tenDienThoai;
    }
  }

  set hangSX(String hangSX) {
    if (hangSX.isNotEmpty) {
      _hangSX = hangSX;
    }
  }

  set giaNhap(double giaNhap) {
    if (giaNhap > 0) {
      _giaNhap = giaNhap;
    }
  }

  set giaBan(double giaBan) {
    if (giaBan > giaNhap) {
      _giaBan = giaBan;
    }
  }

  set soLuongKhoTon(int soLuongKhoTon) {
    if (soLuongKhoTon >= 0) {
      _soLuongKhoTon = soLuongKhoTon;
    }
  }

  set trangThai(bool trangThai) {
    _trangThai = trangThai;
  }

  //Tinh doanh thu du kien
  double doanhThuDuKien() => giaBan * soLuongKhoTon;
  void hienThiThongTin() {
    print('Ma dien thoai: $_maDienThoai');
    print('Ten dien thoai: $_tenDienThoai');
    print('Hang san xuat: $_hangSX');
    print('Gia nhap: $_giaNhap VND');
    print('Gia ban: $_giaBan VND');
    print('So luong kho ton: $_soLuongKhoTon');
    print('Trang thai: $_trangThai');
  }

  //In dien thoai co the ban, trang thai la true
  int coTheBan() {
    if (_soLuongKhoTon > 0 && _trangThai == true) {
      return 1;
    }
    return 0;
  }
}
