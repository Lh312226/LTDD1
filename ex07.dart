import 'dart:io';

void main() {
  int? n;

  do {
    stdout.write("Nhập số nguyên (n ≥ 1): ");
    String? input = stdin.readLineSync();

    if (input != null) {
      n = int.tryParse(input);
      if (n == null || n < 1) {
        print("Vui lòng nhập số nguyên hợp lệ (≥ 1)!");
        n = null;
      }
    }
  } while (n == null);

  int sumOfDivisors = calculateSumOfDivisors(n);

  print("Tổng các ước số của $n là: $sumOfDivisors");
}

int calculateSumOfDivisors(int n) {
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    if (n % i == 0) {
      sum += i;
    }
  }
  return sum;
}
