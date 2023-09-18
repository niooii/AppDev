/*
Iterate through all numbers from 2 to ssquare root of n and for every number check if it divides n 
[because if a number is expressed as n = xy and any of the x or y is greater than the root of n, 
the other must be less than the root value]. 
If we find any number that divides, we return false.
https://www.geeksforgeeks.org/prime-numbers/
*/
import "dart:io";
import "dart:math";

int main()
{
  isFactorOf(int n, int d) => n%d==0;

  bool isPrime(int n)
  {
  // negaitve numbers are not prime.
    if(n<=1)
      return false;

  // Check from 2 to square root of n
    for (int i = 2; i <= sqrt(n); i++)
        if (isFactorOf(n, i))
            return false;
 
    return true;
  }

  int input = int.parse(stdin.readLineSync()!);

  stdout.writeln(
    isPrime(input) ? "$input is prime." : "$input is not prime."
  );
  return 0;
}