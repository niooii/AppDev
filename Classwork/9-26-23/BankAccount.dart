/*
Define a class named `BankAccount` with the following attributes:
   - `accountNumber`: A unique identification for every bank account (use a random number or a sequential number).
   - `balance`: A double that indicates the current balance in the account. Initialize with `0.0`.
   - `accountHolderName`: A string that holds the name of the account holder.

   Inside the `BankAccount` class:
   - Implement a `factory` constructor that creates and returns an instance of `BankAccount`. 
    This constructor should take the `accountHolderName` as a parameter. 
    Use this factory constructor to assign a unique `accountNumber` and set the initial `balance` to `0.0`.
   - Implement a method `deposit` that accepts an amount and increases the `balance` by that amount.
   - Implement a method `displayInfo` that prints the account number, account holder's name, and the balance.
*/

Map<String, int> NameToID = Map();
Map<int, BankAccount> Accounts = Map();

int currentID = 0;

class BankAccount 
{
  BankAccount(this.accountNumber, this.accountHolderName);

  factory BankAccount.Get(String accountHolderName)
  {
    if(NameToID[accountHolderName] == null)
    {
      print("Cannot find name $accountHolderName... creating new account");
      Accounts[currentID] = BankAccount(currentID, accountHolderName);
      NameToID[accountHolderName] = currentID;
      currentID++;
    }
    return Accounts[NameToID[accountHolderName]]!;
  }

  void Deposit(double a)
  {
    balance += a;
  }

  String Info()
  {
    return "$accountHolderName's account with $balance USD. ID: $accountNumber";
  }

  int accountNumber;
  double balance = 0.0;
  String accountHolderName;
}