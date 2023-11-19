import "dart:io";

import "Library.dart";
import "Book.dart";
import "Member.dart";

class LibClient
{
  LibClient(this.lib);

  Library lib;
  Member? member;

  void _register()
  {
    String email = getInput("Enter your email: ");

    Member? m = lib.memberByEmail(email);

    while(m != null)
    {
      email = getInput("A user already exists with this email. Enter a new email or press r to return. ");
      if(email == "r")
        return;
      m = lib.memberByEmail(email);
    }

    String fullname = getInput("Enter your full name: ");

    String username = getInput("Enter your username: ");

    String password = getInput("Enter your desired password: ");

    LibEnum err = lib.registerMember(fullname, username, password, email);
    if(err != LibEnum.OK)
    {
      printErrorMessage(err);
      print("REGISTRATION FALIED.");
      return;
    }

    print("Registration complete! Please sign in.");
    
  }

  void _signin()
  {
    String email = getInput("Enter your email: ");

    Member? m = lib.memberByEmail(email);

    while(m == null)
    {
      email = getInput("A user does not exist with this email. Enter a new email or press r to return. ");
      if(email == "r")
        return;
      m = lib.memberByEmail(email);
    }

    String password = getInput("Hello, ${m.username}! Enter your password: ");
    
    int tries = 0;
    while(m.password != password)
    {
      if(++tries == 3)
        break;
      password = getInput("Incorrect password, try again: ");
    }

    if(tries == 3)
    {
      print("\nYOU HAD YOUR CHANCES, NOW DIE.");
      return;
    }

    member = m;

  }

  void _borrowbook()
  {
    String isbn = getInput("Enter the books ISBN: ");

    LibEnum err = lib.borrowBook(member!.UID, isbn);
    if(err != LibEnum.OK)
    {
      printErrorMessage(err);
      return;
    }
    print("Successfully borrowed book with isbn $isbn.");
  }

  void _addbook()
  {
    String su = getInput("Enter sudo password: ");
    if(lib.sudopass != su)
    {
      print("Authentication failed.");
      return;
    }
    
    String isbn = getInput("ISBN of book? ");
    String name = getInput("Name of book? ");
    
    LibEnum err = lib.addBook(new Book(isbn, name));
    if(err != LibEnum.OK)
    {
      printErrorMessage(err);
      return;
    }

    print("Successfully added book: $name");
  }

  void _removebook()
  {
    String su = getInput("Enter sudo password: ");
    if(lib.sudopass != su)
    {
      print("Authentication failed.");
      return;
    }
    
    String isbn = getInput("ISBN of book? ");
    
    LibEnum err = lib.removeBook(isbn);
    if(err != LibEnum.OK)
    {
      printErrorMessage(err);
      return;
    }

    print("Successfully removed book with ISBN $isbn.");
  }

  void _returnbook()
  {
    String isbn = getInput("Enter the books ISBN: ");

    LibEnum err = lib.returnBook(member!.UID, isbn);
    if(err != LibEnum.OK)
    {
      printErrorMessage(err);
      return;
    }
    print("Successfully returned book with isbn $isbn.");
  }

  void mainLoop()
  {
    while(true)
    {
      bool loggedin = member != null;

      printChoices(loggedin);
      String input = getInput("\nEnter a choice: ");

      int choice = -1;
      try
      {
        choice = int.parse(input);
      }
      catch(e)
      {
        if(e is FormatException)
        {
          stderr.writeln("Please enter a number.");
        }
        else
        {
          stderr.writeln("Unknown error occurred.");
        }

        continue;
      }

      if(!loggedin)
      {
        switch(choice)
        {
          case 1:
            _register();
            break;

          case 2:
            _signin();
            break;

          case 3:
            exit(0);

          default:
            stderr.writeln("Unknown option.");
            break;
        }
      }
      else
      {
        switch(choice)
        {
          case 1:
            _borrowbook();
            break;

          case 2:
            _addbook();
            break;

          case 3:
            _removebook();
            break;

          case 4:
            _returnbook();
            break;

          case 5:
            lib.displayAllBooks();

          default:
            stderr.writeln("Unknown option.");
            break;
        }
      }
    }
  }

  void printChoices(bool loggedin)
  {
    if(!loggedin)
    {
      print("\nWelcome to ${lib.libraryName}!");
      print("1. Create a new account");
      print("2. Sign in to an existing account");
      print("3. Quit");
    }
    else
    {
      print("\nWelcome back, ${member!.username}!");
      print("1. Borrow a book.");
      print("2. Add a book to the library.");
      print("3. Remove a book from the library.");
      print("4. Return a book.");
      print("5. List all books.");
    }
  }

  // some stuff to make my life easier 
  String getInput([String? message])
  {
    if(message != null)
      stdout.write(message);

    return stdin.readLineSync()!;
  }

  void printErrorMessage(LibEnum err) 
  {
    switch (err) {
      case LibEnum.ADD_DUPLICATE:
        stderr.writeln("Book already exists in the system.");
        break;

      case LibEnum.BOOK_NOTFOUND:
        stderr.writeln("Book does not exist in the system.");
        break;

      case LibEnum.REMOVE_NOTFOUND:
        stderr.writeln("Book not found for removal.");
        break;

      case LibEnum.BORROW_NOTFOUND:
        stderr.writeln("Book not found for borrowing.");
        break;

      case LibEnum.BORROW_ALREADYBORROWED:
        stderr.writeln("Book is already borrowed by someone else.");
        break;

      case LibEnum.USERNOTFOUND:
        stderr.writeln("User does not exist.");
        break;

      case LibEnum.REGISTER_DUPLICATE:
        stderr.writeln("User already registered.");
        break;

      case LibEnum.RETURN_NOTBORROWED:
        stderr.writeln("User did not borrow this book.");
        break;

      default:
        stderr.writeln("Unknown error.");
        break;
    }
  }
}

int main()
{
  Book PEPPAPIG = new Book("12235235", "peppapig");
  Book BRUH = new Book("2352354", "georgethepig");
  

  Library lib = new Library("SOME LIBRARY");

  //some defaults to test with
  lib.registerMember("ADMINA???", "blughco", "password", "test@gmail.com");
  lib.addBook(PEPPAPIG);
  lib.addBook(BRUH);

  LibClient client = new LibClient(lib);

  client.mainLoop();
  
  return 0;
}

