
class House
{
  House(ID, Location, Price) : id = ID, location = Location, price = Price;

  String id, location;
  double price;

  @override
  String toString() {
    return "House with ID $id at $location with price $price";
  }
}


int main()
{
  House h1 = House("ahaha", "wwhitestone", 44747.0);
  House h2 = House("bwaahaha", "blackstone", 23234.0);
  House h3 = House("hebhbehbeh", "stone", 4545.23);

  print(h1);
  print(h2);
  print(h3);
  return 0;
}