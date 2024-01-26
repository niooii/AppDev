import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contactsapp/DatabseHelper.dart';
import 'package:contactsapp/Contact.dart';

void main() {
  runApp(SqliteDemoApp());
}

class SqliteDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MainApp(title: 'Your Contacts'),
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  late DatabaseHelper dbHelper;
  final nameController = TextEditingController();
  final phoneNumController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final companyController = TextEditingController();
  final birthdayController = TextEditingController();
  bool isEditing = false;
  late Contact _user;

  @override
  void initState() {
    super.initState();
    this.dbHelper = DatabaseHelper();
    this.dbHelper.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title!),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                hintText: 'Enter their name.', labelText: 'Name'),
                          ),
                          TextFormField(
                            controller: phoneNumController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: const InputDecoration(
                                hintText: 'Enter their number!', labelText: 'Phone number'),
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: 'Enter their contact email.',
                                labelText: 'Email'),
                          ),
                          TextFormField(
                            controller: addressController,
                            decoration: const InputDecoration(
                                hintText: 'Enter their address.',
                                labelText: 'Address'),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: companyController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter their company.',
                                      labelText: 'Company'),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: birthdayController,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter their birthday.',
                                      labelText: 'Birthday'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                new Container(
                                    margin:
                                        new EdgeInsets.symmetric(vertical: 10),
                                    child: new ElevatedButton(
                                      child: const Text('Add Contact'),
                                      onPressed: addOrEditUser,
                                    )),
                              ])
                        ]))),
                Expanded(
                  flex: 1,
                  child: SafeArea(child: userWidget()),
                )
              ],
            )),
          ],
          // hwat is this autoformatting....
        ));
  }

  Future<void> addOrEditUser() async {
    String email = emailController.text;
    String name = nameController.text;
    String num = phoneNumController.text;
    String address = addressController.text;
    String company = companyController.text;
    String birthday = birthdayController.text;

    if (!isEditing) {
      Contact user = new Contact(phone_num: int.parse(num), name: name, email: email, address: address, company: company, birthday: birthday);
      await addUser(user);
    } else {
      _user.email = email;
      _user.phone_num = int.parse(num);
      _user.name = name;
      await updateUser(_user);
    }
    resetData();
    setState(() {});
  }

  Future<int> addUser(Contact user) async {
    return await this.dbHelper.InsertContact(user);
  }

  Future<int> updateUser(Contact user) async {
    return await this.dbHelper.updateUser(user);
  }

  void resetData() {
    nameController.clear();
    phoneNumController.clear();
    emailController.clear();
    isEditing = false;
  }

  Widget userWidget() {
    return FutureBuilder(
      future: dbHelper.RetrieveContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, position) {
                return Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.delete_forever),
                    ),
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) async {
                      await dbHelper
                          .deleteUser(snapshot.data![position].phone_num!);
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => populateFields(snapshot.data![position]),
                      child: Column(
                        children: <Widget>[
                          const Divider(
                            height: 2.0,
                            color: Colors.grey,
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                child: Text(
                                  snapshot.data![position].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                child: Text(
                                  "(${snapshot.data![position].phone_num.toString()})",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                child: Text(
                                  snapshot.data![position].email,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Company:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![position].company,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Address:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![position].address,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Birthday:",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![position].birthday,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 2.0,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ));
              });
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void populateFields(Contact user) {
    _user = user;
    nameController.text = _user.name;
    phoneNumController.text = _user.phone_num.toString();
    emailController.text = _user.email;
    isEditing = true;
  }
}