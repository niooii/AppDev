class Book
{
  Book(this.isbn, this.title);

  

  final String isbn, title;
  int? ownerUID;

  @override
  String toString() {
    return "$title\n$isbn\n${ownerUID == null ? "AVAILABLE" : "UNAVAILABLE"}";
  }
}