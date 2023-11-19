

import 'dart:math';

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

int main()
{
  Set<int> setA = {};
  Set<int> setB = {};

  //populate sets with random numbesr
  Random s = Random.secure();
  for(int i = 0; i < 100; i++)
  {
    int randA = s.nextInt(200);
    while(setA.contains(randA))
      randA = s.nextInt(200);

    setA.add(randA);

    int randB = s.nextInt(200);
    while(setB.contains(randB))
      randB = s.nextInt(200);

    setB.add(randB);
  }
  print(setA.length);

  //find primes in set A
  Set<int> setAPrimes = {};

  for(int x in setA)
  {
    if(isPrime(x))
      setAPrimes.add(x);
  }

  //find intersection of A && B
  Set<int> intersection = setA.intersection(setB);

  //find even numbers in set A and B but not in both.
  Set<int> evenNotInBoth = {};
  
  for(int i = 0; i < 100; i++)
  {
    int aTemp = setA.elementAt(i);
    if(aTemp % 2 == 0 && !intersection.contains(aTemp))
      evenNotInBoth.add(aTemp);
    
    int bTemp = setB.elementAt(i);
    if(bTemp % 2 == 0 && !intersection.contains(bTemp))
      evenNotInBoth.add(bTemp);
  }

  print("intersection: ${intersection}");
  print("union: ${setA.union(setB)}");
  print("primes in set A: ${setAPrimes}");
  print("intersection: ${setA.intersection(setB)}");
  print("Even numbers not in both sets: ${evenNotInBoth}");

  return 0;
}