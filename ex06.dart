import 'dart:io';

void main() {
  int? b;

  do {
    stdout.write("Nhập số nguyên (b ≥ 1): ");
    String? input = stdin.readLineSync();

    if (input != null) {
      b = int.tryParse(input);
      if (b == null || b < 1) {
        print("Vui lòng nhập số nguyên hợp lệ (≥ 1)!");
        b = null;
      }
    }
  } while (b == null);

  String binaryRepresentation = decimalToBinary(b);

  print("Số nhị phân của $b là: $binaryRepresentation");
}

String decimalToBinary(int n) {
  String binary = '';
  while (n > 0) {
    binary = '${n % 2}' + binary;
    n ~/= 2;
  }
  return binary;
}
