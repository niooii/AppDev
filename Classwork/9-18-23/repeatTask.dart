

import 'dart:math';

int main()
{
  int repeatTask(int times, int input, Function task) => times == 0 ? input : repeatTask(times - 1, task(input), task);

  int i = repeatTask(4, 2, (int n){
    return pow(n, 2);
  });

  print(i);
  return 0;
}