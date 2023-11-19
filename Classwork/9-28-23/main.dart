/* 
Add a new task.
View all tasks.
Mark a task as completed.
Exit.
*/

//std includes
import "dart:io";
//external
import "TaskManager.dart";

int main()
{
  TaskManager t = new TaskManager();
  print("tasjkasfaf task manager yes");

  while(true)
  {
    printInstructions();

    int c = getInt();

    switch(c)
    { 
      case 1:
        String title = "";
        while(title.length == 0)
        {
          stdout.write("Enter the task name: ");
          title = stdin.readLineSync()!;
        }

        stdout.write("Enter the description (if none, press enter): ");
        String desc = stdin.readLineSync()!;
        t.addNewTask(title, desc.length == 0 ? null : desc);

        print("Added task successfully.");

      break;

      case 2:
        print(t.allTasksString());
      break;

      case 3:
        stdout.write("Enter the task number on the list: ");
        int c = getInt();

        if(!t.markAsCompleted(c))
          print("ERR: Failed to mark as completed. Maybe it is already complete, or does not exist.");
        else
          print("Marked task as completed.");

      break;

      case 4:
        stdout.write("Enter the task number on the list: ");
        int c = getInt();

        if(!t.removeTask(c))
          print("ERR: Failed to remove. Task does not exist.");
        else
          print("Removed task.");
      break;

      case 5:
        exit(0);
    }

  }

  return 0;
}

void printInstructions()
{
  print("""1. Add a new task.
2. View all tasks.
3. Mark a task as completed.
4. Remove a task from the list.
5. Exit.""");
}

int getInt()
{
  String? input;

  while(input == null)
  {
    input = stdin.readLineSync();
  }

  //i know this can be very not fun when the user
  //inputs a bad number but im too lazy.
  int c = int.parse(input);

  return c;
}