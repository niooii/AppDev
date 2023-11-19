import "dart:io";

class User
{
  User(this.email, this.username, this.password);

  String email, username, password;

  bool PasswordMatches(String pass)
  {
    return password == pass;
  } 
}


int main()
{

  int id = 0;

  Map usermap = new Map();
  usermap[id++] = User("anemail@email.com", "onion", "password");
  usermap[id++] = User("another@email.com", "nioon", "password");

  
  // Passing by value, this is a gold mine for bugs
  User? GetUser({String? username, String? email})
  {
    if(username == null && email == null)
      return null;
    for(int i = 0; i < usermap.length; i++)
    {
      if(usermap[i].username == username || usermap[i].email == email)
        return usermap[i];
    }
    return null;
  }


  print("Press r to register, or s to sign into an existing account.");
  String choice = stdin.readLineSync()!;

  while(choice != "r" && choice != "s")
  {
    print("Press r to register, or s to sign into an existing account.");
    String choice = stdin.readLineSync()!;
  }

  if(choice == "r")
  {
    print("enter an email:");
    String email = stdin.readLineSync()!;
    while(GetUser(email: email) != null)
    {
      print("there already exists a user with this email. Enter a unique email");
      email = stdin.readLineSync()!;
    }


    print("enter your desired username:");
    String username = stdin.readLineSync()!;
    while(GetUser(username: username) != null)
    {
      print("enter a unique username.");
      username = stdin.readLineSync()!;
    }

    print("enter your password:");
    String password = stdin.readLineSync()!;

    usermap[id++] = new User(email, username, password);
    print("registered! please log in.");

  }
  
  print("enter your username:");
    User? user;
    while((user = GetUser(username: stdin.readLineSync()!)) == null)
    {
      print("user doesnt exist, please try again.");
    }

    //compiler yells at me without this,realistically it will never happen.
    if(user == null)
      return -1;

    print("enter your password:");
    int tries = 0;
    String inputPass = stdin.readLineSync()!;
    while(!user.PasswordMatches(inputPass))
    {
      if(tries == 3)
        {
          print("your account has been disabled.");
          exit(-1);
        }
      print("incorrect password, try again (attempt ${++tries} out of 3.)");
      inputPass = stdin.readLineSync()!;
    }

    print("logged in");

  return 0;
}