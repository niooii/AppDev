class Contact {
  int? id;
  int phone_num;
  String name;
  String email;
  String company;
  String address;
  String birthday;

  Contact({this.id, required 
  this.phone_num, required this.name, required this.email, required this.company, required this.address, required this.birthday});

  Contact.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        phone_num = res["phone_num"],
        name = res["name"],
        email = res["email"],
        company = res["company"],
        address = res["address"],
        birthday = res["birthday"];

  Map<String, Object?> toMap() {
    return {'id': id, 'phone_num': phone_num, 'name': name, 'email': email, 'address': address, 'company': company, 'birthday': birthday};
  }
}