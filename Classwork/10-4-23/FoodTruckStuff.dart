import "dart:io";


abstract class FoodTruck
{
  String _name;
  String _location;
  String _owner;
  Map<String, double> _fooditems;

  FoodTruck(this._name, this._location, this._owner, this._fooditems);

  String get name => _name;
  String get location => _location;
  String get owner => _owner;
  Map<String, double> get foodItems => _fooditems;

  void set name(String name) => _name = name;
  void set location(String location) => _location = location;
  void set owner(String owner) => _owner = owner;
  void set foodItems(Map<String, double> m) => _fooditems = foodItems;

  void displayMenu() 
  {
    print("$name Truck Menu:");
    foodItems.forEach((item, price) {
      print("$item - \$${price.toStringAsFixed(2)}");
    });
  }

  void displayInfo();
  
  int orderNum = 0;
  Map<int, List<String>> orders = new Map();
  void placeOrder(List<String> order)
  {
    orders[++orderNum] = order;
    print("Thanks for placing an order! Your order number is: $orderNum");
    
    //theres no way someone places order 751 and order 1 is still pending right
    if(orderNum > 750)
    {
      orderNum = 0;
    }
  }
}

class Jays extends FoodTruck {
  Jays()
      : super("Jay's", "123 Main St", "Jay", {
    "Burger": 8.99,
    "Fries": 2.99,
    "Soda": 1.99,
    "Bottle of water": 1, 
  });

  @override
  void displayInfo() {
    print("Welcome to Jays! Please wait until your order number is called, and pay with cash only.");
  }
}

class Nats extends FoodTruck {
  Nats()
      : super("Nats's", "123 Main St", "Nat", {
    "Burger": 8.99,
    "Fries": 2.99,
    "Soda": 1.99,
    "Bottle of water": 1, 
  });

  @override
  void displayInfo() {
    print("Welcome to Nats! After ordering, wait until you see your number on a post-it, and pay in any way you wish.");
  }
}


int main()
{
  FoodTruck jays = new Jays();
  FoodTruck nats = new Nats();

  print("Order from: \n1. Jays Food Truck\n2. Nats Food Truck");
  int choice = int.parse(stdin.readLineSync()!);
  stdout.write("\n");

  FoodTruck chosen = (choice == 1 ? jays : nats);
  chosen.displayInfo();
  chosen.displayMenu();

  List<String> order = new List.empty(growable: true);
  double totalPrice = 0;
  bool ordering = true;
  while(ordering)
  {
    stdout.write("Enter a menu item to order: ");
    String menuchoice = stdin.readLineSync()!;

    while(!chosen.foodItems.containsKey(menuchoice))
    {
      stdout.write("Enter a valid choice: ");
      menuchoice = stdin.readLineSync()!;
    }

    order.add(menuchoice);
    totalPrice+=chosen.foodItems[menuchoice]!;

    print("Item added! Your total price is $totalPrice.");

    stdout.write("Order another item? (n to quit)");
    String? s;
    if((s = stdin.readLineSync()!.toLowerCase() ) == "n")
    {
      break;
    }
  }

  chosen.placeOrder(order);
  return 0;
}