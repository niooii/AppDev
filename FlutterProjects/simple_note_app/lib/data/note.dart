class Note {
  Note(this.title, this.content) {
    dateCreated = DateTime.now();
  }

  String title, content;
  late DateTime dateCreated;
}

class PersonalNote extends Note {
  PersonalNote(super.title, super.content);
}