class Name
{
  Name(this.givenName, [this.surname, this.surnameIsFirst])
  {
    surnameIsFirst??=false;
  }

  String givenName;
  String? surname;
  bool? surnameIsFirst;

  @override
  String toString()
  {
    return (surname == null) ? (surnameIsFirst! ? "$surname, $givenName" : "$givenName, $surname") : givenName;
  }
}