formatMonth(date) {
  var month = int.parse(date);
  switch (month) {
    case 1:
      return 'ENE';
      break;
    case 2:
      return 'FEB';
      break;
    case 3:
      return 'MAR';
      break;
    case 4:
      return 'ABR';
      break;
    case 5:
      return 'MAY';
      break;
    case 6:
      return 'JUN';
      break;
    case 7:
      return 'JUL';
      break;
    case 8:
      return 'AGO';
      break;
    case 9:
      return 'SET';
      break;
    case 10:
      return 'OCT';
      break;
    case 11:
      return 'NOV';
      break;
    case 12:
      return 'DIC';
      break;
    default:
      return '';
  }
}

formatMonthComplete(date) {
  switch (date) {
    case 1:
      return 'ENERO';
      break;
    case 2:
      return 'FEBRERO';
      break;
    case 3:
      return 'MARZO';
      break;
    case 4:
      return 'ABRIL';
      break;
    case 5:
      return 'MAYO';
      break;
    case 6:
      return 'JUNIO';
      break;
    case 7:
      return 'JULIO';
      break;
    case 8:
      return 'AGOSTO';
      break;
    case 9:
      return 'SEPTIEMBRE';
      break;
    case 10:
      return 'OCTUBRE';
      break;
    case 11:
      return 'NOVIEMBRE';
      break;
    case 12:
      return 'DICIEMBRE';
      break;
    default:
      return '';
  }
}
