import 'dart:math';

String formattedPhone(String phone) {
  final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
  if (cleanPhone.length == 10) {
    return '(${cleanPhone.substring(0, 3)}) ${cleanPhone.substring(3, 6)}-${cleanPhone.substring(6)}';
  } else if (cleanPhone.length == 11 && cleanPhone.startsWith('1')) {
    return '+1 (${cleanPhone.substring(1, 4)}) ${cleanPhone.substring(4, 7)}-${cleanPhone.substring(7)}';
  }
  return phone;
}

String formatAmount(String amount) {
  return "\$ ${amount.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  )}";
}

String generateVietnameseName() {
  final Random random = Random();

  // Common Vietnamese last names
  List<String> lastNames = [
    'Nguyễn',
    'Trần',
    'Lê',
    'Phạm',
    'Huỳnh',
    'Hoàng',
    'Vũ',
    'Đặng',
    'Bùi',
    'Đỗ'
  ];

  // Common Vietnamese middle names
  List<String> middleNames = [
    'Thị',
    'Văn',
    'Thanh',
    'Minh',
    'Đức',
    'Quang',
    'Bảo',
    'Ngọc',
    'Tuấn',
    'Hồng'
  ];

  // Common Vietnamese first names
  List<String> firstNames = [
    'An',
    'Bình',
    'Châu',
    'Duy',
    'Giang',
    'Hạnh',
    'Khánh',
    'Lâm',
    'Nhi',
    'Quyên'
  ];

  // Randomly select each part of the name
  String lastName = lastNames[random.nextInt(lastNames.length)];
  String middleName = middleNames[random.nextInt(middleNames.length)];
  String firstName = firstNames[random.nextInt(firstNames.length)];

  // Assemble the full name
  return '$lastName $middleName $firstName';
}
