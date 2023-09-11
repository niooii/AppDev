
import 'dart:io';
import 'dart:math';

void main() {
  // form ax^2 + bx + c = 0
  
  print("enter value a: ");
  int a = int.parse(stdin.readLineSync()!);
  print("enter value b:");
  int b = int.parse(stdin.readLineSync()!);
  print("enter value c");
  int c = int.parse(stdin.readLineSync()!);

  List solutions = GetSolutions(a, b, c);

  if(solutions.isEmpty)
  {
    print("no real solutions.");
    return;
  }

  print("all real solutions: ");
  for(num n in solutions)
  {
    print(n);
  }
}

List GetSolutions(int a, int b, int c)
{

  if(pow(b, 2) - 4*a*c < 0)
  {
    return [];
  }

  double x1 = (-b + sqrt(pow(b, 2) - 4*a*c))/(2*a);
  double x2 = (-b - sqrt(pow(b, 2) - 4*a*c))/(2*a);

  return [x1, x2];
}