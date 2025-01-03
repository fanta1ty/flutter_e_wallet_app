String formattedPhone(String phone) {
  final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
  if (cleanPhone.length == 10) {
    return '(${cleanPhone.substring(0, 3)}) ${cleanPhone.substring(3, 6)}-${cleanPhone.substring(6)}';
  } else if (cleanPhone.length == 11 && cleanPhone.startsWith('1')) {
    return '+1 (${cleanPhone.substring(1, 4)}) ${cleanPhone.substring(4, 7)}-${cleanPhone.substring(7)}';
  }
  return phone;
}
