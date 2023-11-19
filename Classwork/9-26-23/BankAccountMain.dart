import "dart:io";
import "BankAccount.dart";

enum Action
{
  CREATE,
  DEPOSIT,
  DISPLAY_DETAILS,
  QUIT,
}

int main()
{
  while(true)
  {
    switch(Action.values[GetChoice()])
    {

      case Action.CREATE:
        stdout.write("Enter your name: ");
        String name = stdin.readLineSync()!;

        BankAccount.Get(name);

        stdout.write("Account created!");
        break;
      case Action.DEPOSIT:
        stdout.write("Enter your name: ");
        String name = stdin.readLineSync()!;
        stdout.write("Enter your deposit amount: ");
        double depo = double.parse(stdin.readLineSync()!);
        BankAccount.Get(name).Deposit(depo);
        stdout.write("$depo deposited in your account!\n");
        break;
      case Action.DISPLAY_DETAILS: 
        stdout.write("Enter your name: ");
        String name = stdin.readLineSync()!;
        print(BankAccount.Get(name).Info());
        break;
      case Action.QUIT:
        exit(0);
    }
  }

  return 0;
}

int GetChoice()
{
  stdout.write("""\n=== Bank Account Management ===
  1. Create New Account
  2. Deposit Money
  3. Display Account Details
  4. Quit
  Enter your choice: """);

  return int.parse(stdin.readLineSync()!) - 1;
}