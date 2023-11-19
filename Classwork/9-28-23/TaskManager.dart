/*

The Task Manager should store tasks in a List.
Users should be able to add new tasks by providing a title and an optional description.
Users should be able to view all tasks (both pending and completed) 
along with their titles and descriptions.
Users should be able to mark a task as completed.

*/

import "Task.dart";

class TaskManager
{
  List<Task> tasks = List.empty(growable: true);

  String allTasksString()
  {
    if(tasks.length == 0)
      return "All done!";

    String s = "";

    for(int i = 0; i < tasks.length; i++)
    {
      s += "=================================\nTASK ${i+1}:\n${tasks[i]}\n";
    }

    return s;
  }

  bool markAsCompleted(int listing)
  {
    int idx = listing-1;
    if(idx >= tasks.length)
      return false;
    
    if(tasks[idx].status == STATUS.COMPLETE)
      return false;

    tasks[idx].status = STATUS.COMPLETE;
    return true;
  }

  void addNewTask(String taskName, [String? description])
  {
    tasks.add(new Task(taskName, description));
  }

  bool removeTask(int listing)
  {
    int idx = listing-1;

    if(idx >= tasks.length)
      return false;
      
    tasks.removeAt(idx);

    return true;
  }
}