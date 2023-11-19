import 'dart:io';
import 'dart:math';

int main()
{
  stdout.write("enter numbe: ");
  int input = int.parse(stdin.readLineSync()!);
  assert(input >= 0);

  stdout.write("the sqrt of $input == ${sqrt(input)}\n");

  return 0;
}