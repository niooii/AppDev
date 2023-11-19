abstract class Bottle
{
  Bottle();
  factory Bottle.sodaBottle()
  {
    return new SodaBottle();
  }

  void Open();
}

class SodaBottle extends Bottle
{
  @override
  void Open()
  {
    print("fizz fizz");
  }
}

int main()
{
  Bottle.sodaBottle().Open();

  return 0;
}