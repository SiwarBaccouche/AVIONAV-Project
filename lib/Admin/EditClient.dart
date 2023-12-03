import '../Constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditClient extends StatefulWidget {
  String? clientKey;
  String? name;
  String? email;
  String? phone;
  String? role;

  EditClient({this.clientKey,this.phone,this.name,this.email,this.role});
  @override
  _EditClientState createState() => _EditClientState();
}

class _EditClientState extends State<EditClient> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  DatabaseReference _ref = FirebaseDatabase.instance.ref().child('Client');

  /// admin or client
  String _typeSelected = '';




  void saveClient() {
    String name = _nameController.text;
    String number = _numberController.text;
    String Email = _EmailController.text;
    String role = _typeSelected;

    Map<String, String> client = {
      'Full Name': name,
      'Phone': number,
      'Role': role,
      'Email': Email,
    };

    //twali child t3adih widget.email
    _ref.child(widget.clientKey!).update(
        client
    ).then((value) {
      Navigator.pop(context);
    });
  }




  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name!;
    _numberController.text = widget.phone!;
    _EmailController.text = widget.email!;
    _typeSelected = widget.role!;
    //getContactDetail();
  }

  Widget _buildClientType(String title) {
    return InkWell(
      child: Container(
        height: 40,
        width: 90,
        decoration: BoxDecoration(
          color: _typeSelected == title
              ? Colors.green
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Client'),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// name
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter Full Name',
                hintStyle: TextStyle(
                    color: kHintTextColor.withOpacity(0.5), fontSize: 15),
                prefixIcon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                  size: 30,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: kPrimaryColor.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: kPrimaryColor)),
                contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 15),
            /// email
            TextFormField(
              controller: _EmailController,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                    color: kHintTextColor.withOpacity(0.5), fontSize: 15),
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: kPrimaryColor,
                  size: 30,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: kPrimaryColor.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: kPrimaryColor)),
                contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 15),
            /// number
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                hintText: 'Enter Number',
                hintStyle: TextStyle(
                    color: kHintTextColor.withOpacity(0.5), fontSize: 15),
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: kPrimaryColor,
                  size: 30,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: kPrimaryColor.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: kPrimaryColor)),
                contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            /// adlin or client
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildClientType('Client'),
                  SizedBox(width: 10),
                  _buildClientType('Admin'),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
                child: ButtonTheme(
              minWidth: 200.0,
              height: 45.0,
              child: RaisedButton(
                color: kPrimaryColor,
                onPressed: () {
                  /// update button
                  saveClient();
                  //debugPrint("key     :" + widget.clientKey.toString());
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: kTextColor,
                  ),
                ),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: kPrimaryColor.withOpacity(0.5))),
              ),
            )),
          ],
        ),
      ),
    );
  }


}
