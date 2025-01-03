String fetchBankImageWith(String bankCode) {
  switch (bankCode.toLowerCase()) {
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

String fetchBankNameWith(String bankCode) {
  switch (bankCode.toLowerCase()) {
    case 'vcb':
      return 'Vietcombank (VCB)';
    case 'ctg':
      return 'VietinBank (CTG)';
    case 'mbb':
      return 'MBBank (MBB)';
    case 'acb':
      return 'ACB';
    case 'hdb':
      return 'HDBank (HDB)';
    case 'tpb':
      return 'TPBank (TPB)';
    case 'ocb':
      return 'OCB';
    case 'scb':
      return 'SCB';
    default:
      return 'Techcombank (TCB)';
  }
}
