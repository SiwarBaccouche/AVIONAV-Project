//@dart=2.9
import '../AddClient.dart';
import '../Constants.dart';
import '../EditClient.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  Query _ref =FirebaseDatabase.instance.ref().child('Client');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Client');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _buildClientItem({Map client}) {
    //Color typeColor = getTypeColor(client['Privilege']);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 220,
      color: Colors.pink.shade50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
              SizedBox(
                width: 8,
              ),
              /// full name
              Text(
                client['Full Name'].toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.remove_circle_rounded,
                color: Colors.red,
              ),
              SizedBox(
                width: 6,
              ),
              /// role
              Text(
                  client['Role'].toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: kHintTextColor,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.mail,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              /// email
              Text(
                client['Email'].toString(),
                style: TextStyle(
                    fontSize: 14,
                    color: kHintTextColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Icon(
              Icons.phone_iphone,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            SizedBox(
              width: 6,
            ),
            /// phone
            Text(
              client['Phone'].toString(),
              style: TextStyle(
                  fontSize: 16,
                  color: kHintTextColor,
                  fontWeight: FontWeight.w600),
            ),
          ]),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.group_work,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              /// Airplane
              Text(
                client['Airplane'].toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: kHintTextColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {

                  Navigator.push(context, MaterialPageRoute(
                          builder: (_) => EditClient(
                                clientKey: client['key'],
                                email: client['Email'],
                                role: client['Role'],
                                phone: client['Phone'],
                                name: client['Full Name'],
                              )));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('Edit',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  /// delete user
                  _showDeleteDialog(client: client);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red[700],
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('Delete',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red[700],
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  _showDeleteDialog({Map client}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${client['Full Name']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    /// DELETEE fb
                    reference.child(client['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Clients'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        height: double.infinity,
        /// list of clients
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map client = snapshot.value;
            client['key'] = snapshot.key;
            /// edit client
            return _buildClientItem(client: client);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              /// add User
              return AddClient();
            }),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;

    if (type == 'Admin') {
      color = Colors.green;
    }

    if (type == 'Client') {
      //  color = Color.fromARGB(255, 132, 118, 252);
      color = kHintTextColor;
    }
    return color;
  }
}
