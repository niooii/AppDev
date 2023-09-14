import 'dart:io';
import 'dart:math';

void main() {

  while (true) {
    bool getNewValue = false;

    stdout.write("Enter the value you want to convert: ");
    final String original = stdin.readLineSync().toString();

    stdout.write("Enter the current base: ");
    final int originalBase = int.parse(stdin.readLineSync().toString());

    stdout.write("Enter the new base: ");
    int newBase = int.parse(stdin.readLineSync().toString());

    while (!getNewValue) {
      final result = convert(original, originalBase, newBase);

      print("$original converted to base $newBase = $result");
      stdout.write("Enter 'n' to convert a new number, or enter a new base: ");

      String temp = stdin.readLineSync().toString();
      if (temp.toLowerCase() == 'n') {
        getNewValue = true;
      } else {
        newBase = int.parse(temp);
      }
    }
  }
}

String convert(String original, int originalBase, int newBase) {
  int decimal = 0;

  if (originalBase != 10) {
    decimal = convertToDecimal(original, originalBase);
  } else {
    decimal = int.parse(original);
  }

  return convertToNewBase(decimal, newBase);
}

int convertToDecimal(String numToConvert, int currentBase) {
  int result = 0;
  int stringIndex = 0;

  for (int i = numToConvert.length - 1; i >= 0; i--) {
    final digit = numToConvert[stringIndex];
    result += (chartoNum(digit) * pow(currentBase, i)).toInt();
    stringIndex++;
  }

  return result;
}

String convertToNewBase(int decimalVal, int newBase) {
  String result = "";

  while (decimalVal != 0) {
    final digit = decimalVal % newBase;
    final digitChar = String.fromCharCode(digit < 10 ? digit + 48 : digit + 55);

    result = digitChar + result;
    decimalVal ~/= newBase;
  }

  return result;
}

int chartoNum(String character) {
  switch (character) {
    case 'A':
      return 10;
    case 'B':
      return 11;
    case 'C':
      return 12;
    case 'D':
      return 13;
    case 'E':
      return 14;
    case 'F':
      return 15;
    default:
      return int.parse(character);
  }
}
