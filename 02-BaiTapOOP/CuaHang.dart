import 'DienThoai.dart';
import 'HoaDon.dart';

class Cuahang {
  String _tenCH;
  String _diaChi;
  List<DienThoai> _danhSachDienThoai = [];
  List<Hoadon> _danhSachHoaDon = [];

  Cuahang(this._tenCH, this._diaChi);
  String get tenCH => _tenCH;
  set tenCH(String tenCH) {
    if (tenCH.isNotEmpty) {
      _tenCH = tenCH;
    }
  }

  String get diaChi => _diaChi;
  set diaChi(String diaChi) {
    if (diaChi.isNotEmpty) {
      _diaChi = diaChi;
    }
  }

  List<DienThoai> get danhSachDienThoai => _danhSachDienThoai;
  List<Hoadon> get danhSachHoaDon => _danhSachHoaDon;
  //Them dien thoai
  void themDienThoai(DienThoai dienThoai) {
    _danhSachDienThoai.add(dienThoai);
  }

  //Cap nhat
  void capNhatDienThoai(DienThoai dienThoai) {
    for (var i = 0; i < _danhSachDienThoai.length; i++) {
      if (_danhSachDienThoai[i].maDienThoai == dienThoai.maDienThoai) {
        _danhSachDienThoai[i] = dienThoai;
      }
    }
  }

  //Chuyen trang thai dien thoai thanh false == ngung kinh doanh
  void ngungKD(DienThoai dienThoai) {
    for (var i = 0; i < _danhSachDienThoai.length; i++) {
      if (_danhSachDienThoai[i].maDienThoai == dienThoai.maDienThoai &&
          _danhSachDienThoai[i].trangThai == true) {
        _danhSachDienThoai[i].trangThai = false;
      }
    }
  }

  //Tim kiem dien thoai
  List<DienThoai> timKiemDienThoai({String? ma, String? ten, String? hang}) {
    // Kiểm tra danh sách rỗng
    if (_danhSachDienThoai.isEmpty) {
      print('Danh sách điện thoại trống.');
      return [];
    }

    // Lọc danh sách dựa trên các tiêu chí
    return _danhSachDienThoai.where((dienThoai) {
      bool matchMa = ma == null || dienThoai.maDienThoai.contains(ma);
      bool matchTen = ten == null || dienThoai.tenDienThoai.contains(ten);
      bool matchHang = hang == null || dienThoai.hangSX.contains(hang);

      return matchMa && matchTen && matchHang;
    }).toList();
  }

  //In danh sach dien thoai cua CH
  void inDT() {
    for (var dienThoai in _danhSachDienThoai) {
      print('''- Mã điện thoại: ${dienThoai.maDienThoai}, 
          Tên: ${dienThoai.tenDienThoai}, 
          Giá nhập: ${dienThoai.giaNhap},
          Hãng sản xuất: ${dienThoai.hangSX},
          Giá bán: ${dienThoai.giaBan}, 
          Số lượng tồn: ${dienThoai.soLuongKhoTon}, 
          Trang thai: ${dienThoai.trangThai}''');
    }
  }

  //Tao hoa don moi
  void taoHoaDon(String maHoaDon, DateTime ngayBan, String maDienThoai,
      int soLuongMua, String tenKhachHang, String soDienThoai) {
    // Tìm điện thoại theo mã
    var dienThoai = _danhSachDienThoai.firstWhere(
      (dt) => dt.maDienThoai == maDienThoai,
      orElse: () =>
          throw Exception('Không tìm thấy điện thoại với mã: $maDienThoai'),
    );

    // Kiểm tra số lượng tồn kho
    if (dienThoai.soLuongKhoTon < soLuongMua) {
      throw Exception('Không đủ số lượng tồn kho để bán.');
    }

    // Tạo hóa đơn mới
    var hoaDon = Hoadon(
      maHoaDon,
      ngayBan,
      dienThoai,
      dienThoai.giaBan,
      soDienThoai,
      soLuongMua,
      tenKhachHang,
    );

    // Cập nhật tồn kho
    dienThoai.soLuongKhoTon -= soLuongMua;

    // Thêm hóa đơn vào danh sách
    _danhSachHoaDon.add(hoaDon);
  }

  //Tim kiem hoa don
  void timKiemHoaDon(
      {String? maHoaDon, DateTime? ngayBan, String? tenKhachHang}) {
    // Lọc danh sách hóa đơn theo các điều kiện
    var hoaDons = _danhSachHoaDon.where((hoaDon) {
      bool isMatch = true;

      if (maHoaDon != null && hoaDon.maHoaDon != maHoaDon) {
        isMatch = false;
      }

      if (ngayBan != null && hoaDon.ngayBan != ngayBan) {
        isMatch = false;
      }

      if (tenKhachHang != null && hoaDon.tenKhachHang != tenKhachHang) {
        isMatch = false;
      }

      return isMatch;
    }).toList();

    // Kiểm tra và in kết quả tìm kiếm
    if (hoaDons.isEmpty) {
      print('Không tìm thấy hóa đơn nào phù hợp.');
    } else {
      print('Danh sách hóa đơn tìm thấy:');
      for (var hoaDon in hoaDons) {
        hoaDon.hienThiHoaDon(); // Hiển thị hóa đơn
      }
    }
  }

  //Hien thi danh sach hoa don
  void hienThiDanhSachHoaDon() {
    if (_danhSachHoaDon.isEmpty) {
      print('Danh sách hóa đơn trống.');
    } else {
      for (var hoaDon in _danhSachHoaDon) {
        hoaDon.hienThiHoaDon(); // Gọi phương thức hiển thị thông tin hóa đơn
        print('---'); // Ngăn cách các hóa đơn
      }
    }
  }

  //Tong doanh thu
  double tongDoanhThu(DateTime startDate, DateTime endDate) {
    double tongDoanhThu = 0.0;

    // Lặp qua tất cả các hóa đơn
    for (var hoaDon in _danhSachHoaDon) {
      // Kiểm tra nếu ngày bán của hóa đơn nằm trong khoảng thời gian
      if (hoaDon.ngayBan.isAfter(startDate) &&
          hoaDon.ngayBan.isBefore(endDate)) {
        tongDoanhThu += hoaDon.tongTien();
      }
    }

    return tongDoanhThu;
  }

  //Tong loi nhuan
  double tongLoiNhuan(DateTime startDate, DateTime endDate) {
    double tongLoiNhuan = 0.0;

    // Lặp qua tất cả các hóa đơn
    for (var hoaDon in _danhSachHoaDon) {
      // Kiểm tra nếu ngày bán của hóa đơn nằm trong khoảng thời gian
      if (hoaDon.ngayBan.isAfter(startDate) &&
          hoaDon.ngayBan.isBefore(endDate)) {
        tongLoiNhuan += hoaDon.loiNhuan();
      }
    }

    return tongLoiNhuan;
  }

  List<Map<String, dynamic>> topDienThoaiBanChay() {
    Map<String, int> soLuongBan = {};

    // Lặp qua tất cả các hóa đơn và tính số lượng bán cho từng điện thoại
    for (var hoaDon in _danhSachHoaDon) {
      String maDienThoai = hoaDon.dienThoaiBanDuoc.maDienThoai;
      int soLuong = hoaDon.soLuongMua;

      if (soLuongBan.containsKey(maDienThoai)) {
        soLuongBan[maDienThoai] = soLuongBan[maDienThoai]! + soLuong;
      } else {
        soLuongBan[maDienThoai] = soLuong;
      }
    }

    // Sắp xếp danh sách điện thoại theo số lượng bán
    var sortedList = soLuongBan.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Chuyển đổi thành danh sách các điện thoại bán chạy
    List<Map<String, dynamic>> result = [];
    for (var entry in sortedList) {
      result.add({
        'maDienThoai': entry.key,
        'soLuongBan': entry.value,
      });
    }

    return result;
  }

  List<Map<String, dynamic>> thongKeTonKho() {
    List<Map<String, dynamic>> tonKho = [];

    // Lặp qua danh sách các điện thoại trong cửa hàng
    for (var dienThoai in _danhSachDienThoai) {
      tonKho.add({
        'maDienThoai': dienThoai.maDienThoai,
        'soLuongKhoTon': dienThoai.soLuongKhoTon,
      });
    }

    return tonKho;
  }
}
