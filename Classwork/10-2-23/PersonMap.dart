

int main()
{
  Map somemap = {"name" : "Hewitt", "Profession" : "Student", "Country" : "USA", "City" : "Flushing"};

  //i move to Toronto, Canada apparently
  somemap["Country"] = "Canada";
  somemap["City"] = "Toronto";

  for(MapEntry e in somemap.entries)
  {
    print("${e.key}: ${e.value}");
  }

  return 0;
}