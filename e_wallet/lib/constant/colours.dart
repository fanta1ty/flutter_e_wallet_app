import 'package:flutter/material.dart';

const Color Background = Color(0xFFffffff);
// const Color boldtxt = Color(0xFF1d58cf);
const Color btn = Color(0xFF662bb3);
const Color btntxt = Color(0xFF662bb3);

String fetchBankImageWith(String bankCode) {
  switch (bankCode) {
    case 'vcb':
      return 'assets/image/bank_2.png';
    case 'ctg':
      return 'assets/image/bank_3.png';
    case 'mbb':
      return 'assets/image/bank_4.png';
    case 'acb':
      return 'assets/image/bank_5.png';
    case 'hdb':
      return 'assets/image/bank_6.png';
    case 'tpb':
      return 'assets/image/bank_7.png';
    case 'ocb':
      return 'assets/image/bank_8.png';
    case 'scb':
      return 'assets/image/bank_9.png';
    default:
      return 'assets/image/bank_1.jpg';
  }
}
