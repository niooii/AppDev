
import 'dart:math';

int main()
{
  int result = _42ornull() ?? 42;
  print(result);
  return 0;
}

int? _42ornull()
{
  Random r = Random.secure();
  return r.nextInt(2) == 0 ? 42 : null;
}