import "dart:io";

void main()
{
  double a = GetDouble();
  double b = GetDouble();

  print("sum: ${a+b}\nproduct: ${a*b}");
}

double GetDouble()
{
  String s = stdin.readLineSync().toString();
  return double.parse(s);
}