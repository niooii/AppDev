

int main()
{
  String name = "examplename";
  print(youAreWonderful(name: name, numberPeople: 20));
  return 0;
}

String youAreWonderful({required String name, int? numberPeople = 30})
{
  return ((numberPeople == null) ? "You are wonderful, $name!" :
   "You are wonderful, $name! $numberPeople people think so.");
}