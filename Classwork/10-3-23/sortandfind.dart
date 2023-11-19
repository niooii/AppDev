

int main()
{
  final scores = [89, 77, 46, 93, 82, 67, 32, 88];

  scores.sort();
  
  int highest = scores[scores.length - 1];
  int lowest = scores[0];

  print("highest score: $highest, lowest score: $lowest");

  Iterable<int> i = scores.where((element) => 88 < element && element < 90);

  for(int B in i)
  {
    print(B);
  }

  return 0;
}