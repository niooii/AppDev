import "dart:core";
import "Book.dart";
import "Member.dart";

enum LibEnum
{
  OK,

  BOOK_AVAILABLE,
  BOOK_UNAVAILABLE,
  BOOK_NOTFOUND,

  ADD_DUPLICATE,
  
  REMOVE_NOTFOUND,

  BORROW_NOTFOUND,
  BORROW_ALREADYBORROWED,
  USERNOTFOUND,

  RETURN_NOTBORROWED,

  REGISTER_DUPLICATE,

  NONE
  
}


class Library
{
  Library(this.libraryName);

  String sudopass = "admin";

  String libraryName;
  static int nextFreeUID = 0;

  //isbn to book
  Map<String, Book> books = new Map();
  //member to borrowed books
  Set<Member?> members = new Set();
  
  LibEnum lastEnum = LibEnum.NONE;
  LibEnum getLastError()
  {
    return lastEnum;
  }

  String getEnumString(LibEnum e)
  {
    return e.name;
  }

  LibEnum addBook(Book book)
  {
    if(books.containsKey(book.isbn))
    {
      return LibEnum.ADD_DUPLICATE;
    }

    books[book.isbn] = book;
    return LibEnum.OK;
  }

  LibEnum removeBook(String isbn)
  {
    if(!books.containsKey(isbn))
    {
      return LibEnum.REMOVE_NOTFOUND;
    }

    books.remove(isbn);
    return LibEnum.OK;
  }

  LibEnum borrowBook(int UID, String isbn)
  {
    if(members.where((m) => m!.UID == UID).length == 0)
        return LibEnum.USERNOTFOUND;
        
    LibEnum status = _getBookStatus(isbn);
    switch(status)
    {
      case LibEnum.BOOK_UNAVAILABLE:
        lastEnum = LibEnum.BORROW_ALREADYBORROWED;
        return LibEnum.BORROW_ALREADYBORROWED;

      case LibEnum.BOOK_NOTFOUND:
        lastEnum = LibEnum.BORROW_NOTFOUND;
        return LibEnum.BORROW_NOTFOUND;

      default:
        
    }

    Book? b = _fromIsbn(isbn);

    if(b!.ownerUID != null)
    {
      lastEnum = LibEnum.BORROW_ALREADYBORROWED;
      return LibEnum.BORROW_ALREADYBORROWED;
    }
    else
    {
      b.ownerUID = UID;
      return LibEnum.OK;
    }
  }

  LibEnum returnBook(int UID, String isbn)
  {
    if(members.where((m) => m!.UID == UID).length == 0)
        return LibEnum.USERNOTFOUND;
        
    LibEnum status = _getBookStatus(isbn);
    switch(status)
    {
      case LibEnum.BOOK_NOTFOUND:
        lastEnum = LibEnum.BOOK_NOTFOUND;
        return LibEnum.BOOK_NOTFOUND;

      default:
        
    }

    Book? b = _fromIsbn(isbn);

    if(b!.ownerUID != UID)
    {
      lastEnum = LibEnum.RETURN_NOTBORROWED;
      return LibEnum.RETURN_NOTBORROWED;
    }
    else
    {
      b.ownerUID = null;
      return LibEnum.OK;
    }
  }

  LibEnum registerMember(String name, String username, String password, String email)
  {
    //server side validation maybe?
    Member? m = members.firstWhere(((m) => m!.email == email), orElse: () => null);
    if(m==null)
    {
      members.add(new Member(name, nextFreeUID++, username, password, email));
      return LibEnum.OK;
    }
    //duplicate has been found
    else
    {
      lastEnum = LibEnum.REGISTER_DUPLICATE;
      return LibEnum.REGISTER_DUPLICATE;
    }

  }

  Member? memberByEmail(String email)
  {
    Member? m = members.firstWhere(((m) => m!.email == email), orElse: () => null);
    return m;
  }

  void displayAllBooks()
  {
    for(Book b in books.values)
    {
      print(b);
      print("------------------------");
    }
  }

  //private function declarations:
  LibEnum _getBookStatus(String isbn)
  {
    Book? b;
    if((b = _fromIsbn(isbn)) == null)
    {
      return LibEnum.BOOK_NOTFOUND;
    }
    
    if(b!.ownerUID == null)
    {
      return LibEnum.BOOK_AVAILABLE;
    }
    else
    {
      return LibEnum.BOOK_UNAVAILABLE;
    }
    
  }

  //returns null if no book can be found.
  Book? _fromIsbn(String isbn)
  {
    if(books.containsKey(isbn))
      return books[isbn];
    return null;
  }
}