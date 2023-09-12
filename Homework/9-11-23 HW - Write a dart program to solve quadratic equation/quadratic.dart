import 'dart:math';

void main() {
  // form ax^2 + bx + c = 0

  const double a = 1;
  const double b = 2;
  const double c = 1;

  List solutions = GetSolutions(a, b, c);

  if (solutions.isEmpty) {
    print("no real solutions.");
    return;
  }

  print("all real solutions: ");
  for (num n in solutions) {
    print(n);
  }
}

List GetSolutions(double a, double b, double c) {
  if (pow(b, 2) - 4 * a * c < 0) {
    return [];
  }

  double x1 = (-b + sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);
  double x2 = (-b - sqrt(pow(b, 2) - 4 * a * c)) / (2 * a);

  return [x1, x2];
}
