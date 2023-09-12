import "dart:math";
import "dart:io";

int main()
{
  print("Enter a password length: ");
  String s = stdin.readLineSync().toString();
  int len = int.parse(s);

  String pass = "";
  for(int i = 0; i < len; i++)
  {
    //valid ascii codes for valid password characters should be from
    //range [33, 126]
    pass += String.fromCharCode(Random.secure().nextInt(93) + 33);
  }
  print("your password is:");
  print(pass);
  return 0;
}