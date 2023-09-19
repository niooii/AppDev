
class Student
{
  Student(String osis, String name, double grade, double gpa) 
  : OSIS=osis, Name=name, Grade=grade, GPA=gpa;

  String OSIS;
  String Name;
  double Grade;
  double GPA;

  @override
  String toString() {
    return "STUDENT: $Name, $OSIS, $Grade, $GPA";
  }
}

class BronxScienceStudent extends Student
{
  BronxScienceStudent(String osis, String name, double grade, double gpa, String attr1, String attr2, String attr3)
  : attr1=attr1, attr2=attr2, attr3=attr3, super(osis, name, grade, gpa);

  String attr1;
  String attr2;
  String attr3;

  @override
  String toString() {
    return "BXSCI STUDENT: $Name, $OSIS, $Grade, $GPA\nattribute 1: $attr1\nattribute 2: $attr2\nattribute 3: $attr3";
  }
}

int main()
{
  Student a = new Student("228435242", "Foo Bar", 90, 3.8);
  Student b = new Student("228435242", "Foo Baz", 81, 3.2);

  print(a);
  print(b);

  Student bxsci1 = new BronxScienceStudent("24243434", "APPLE", 40, -2, "i am", "sleep", "deprived!");
  Student bxsci2 = new BronxScienceStudent("42343434", "BANANA", 30, -4, "i am", "very", "depressed.");

  print(bxsci1);
  print(bxsci2);
  return 0;
}