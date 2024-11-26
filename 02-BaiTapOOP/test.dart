import 'CuaHang.dart';
import 'DienThoai.dart';
import 'HoaDon.dart';

void main() {
  // Tạo cửa hàng mới
  var cuaHang = Cuahang("Cửa hàng ABC", "123 Đường ABC, TP.HCM");

  // Thêm điện thoại mới vào cửa hàng
  var dt1 = DienThoai(
      'DT-001', 'iPhone 14 Pro Max', 'Apple', 25000000, 30000000, 50, true);
  cuaHang.themDienThoai(dt1);
  print("Danh sách điện thoại sau khi thêm:");
  cuaHang.inDT();

  // Cập nhật thông tin điện thoại
  var dt2 = DienThoai(
      'DT-001', 'iPhone 14 Pro Max', 'Apple', 27000000, 32000000, 50, true);
  cuaHang.capNhatDienThoai(dt2);
  print("Danh sách điện thoại sau khi cập nhật:");
  cuaHang.inDT();

  // Kiểm tra validation khi thêm điện thoại với thông tin không hợp lệ
  var dt3 = DienThoai('DT-001', '', 'Apple', 26000000, 31000000, 40, true);
  cuaHang.themDienThoai(dt3); // Kiểm tra trường hợp không hợp lệ

  // Tạo hóa đơn hợp lệ
  var hoaDon1 = Hoadon(
    'HD-001',
    DateTime(2024, 11, 27),
    dt1,
    30000000,
    '0123456789',
    2,
    'Nguyễn Văn A',
  );
  cuaHang.taoHoaDon(
    hoaDon1.maHoaDon,
    hoaDon1.ngayBan,
    hoaDon1.dienThoaiBanDuoc.maDienThoai,
    hoaDon1.soLuongMua,
    hoaDon1.tenKhachHang,
    hoaDon1.soDienThoai,
  );
  print("Danh sách hóa đơn sau khi thêm:");
  cuaHang.hienThiDanhSachHoaDon();

  // Kiểm tra các ràng buộc khi tạo hóa đơn (tồn kho, validation)
  var hoaDon2 = Hoadon(
    'HD-002',
    DateTime(2024, 11, 28),
    dt1,
    30000000,
    '0987654321',
    55, // Số lượng vượt quá tồn kho
    'Nguyễn Thị B',
  );
  cuaHang.taoHoaDon(
    hoaDon2.maHoaDon,
    hoaDon2.ngayBan,
    hoaDon2.dienThoaiBanDuoc.maDienThoai,
    hoaDon2.soLuongMua,
    hoaDon2.tenKhachHang,
    hoaDon2.soDienThoai,
  );

  // Tính toán tiền và lợi nhuận từ hóa đơn
  print("Tổng tiền hóa đơn HD-001: ${hoaDon1.tongTien()}");
  print("Lợi nhuận hóa đơn HD-001: ${hoaDon1.loiNhuan()}");

  // Thống kê báo cáo
  var startDate = DateTime(2024, 11, 26);
  var endDate = DateTime(2024, 11, 30);
  var tongDoanhThu = cuaHang.tongDoanhThu(startDate, endDate);
  print("Tổng doanh thu từ $startDate đến $endDate: $tongDoanhThu");

  var tongLoiNhuan = cuaHang.tongLoiNhuan(startDate, endDate);
  print("Tổng lợi nhuận từ $startDate đến $endDate: $tongLoiNhuan");

  var topDienThoai = cuaHang.topDienThoaiBanChay();
  print("Top điện thoại bán chạy: $topDienThoai");

  var tonKho = cuaHang.thongKeTonKho();
  print("Tồn kho hiện tại: $tonKho");
}
