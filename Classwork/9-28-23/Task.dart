/*
Each task should have a title, which is a non-nullable string.
Each task should have a description, which is a nullable string. 
Not all tasks will have descriptions.
Each task should have a status, 
which indicates whether the task is pending or completed. 
Use the late keyword to initialize this variable after the class's constructor.
*/
enum STATUS
{
  COMPLETE,
  INCOMPLETE,
}

class Task
{
  Task(this.title, [this.description = null])
  {
    status = STATUS.INCOMPLETE;
  }

  @override
  String toString() 
  {
    String? dtemp = description != null ? description! + "\n" : "";
    return "$title\n${dtemp}${status == STATUS.INCOMPLETE ? "Incomplete" : "Complete"}";
  }

  String title;
  String? description;
  late STATUS status;

}