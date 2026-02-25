import 'package:flutter/material.dart';
import 'add_contact_page.dart';

class ContactListPage extends StatefulWidget {
  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Map<String, String>> contacts = [
    {"name": "Keerthi", "phone": "9782145678"},
    {"name": "Tarun", "phone": "9123456780"},
    {"name": "Vikram", "phone": "9988776655"},
    {"name": "Priya", "phone": "9012345678"},
    {"name": "Arjun", "phone": "9090909090"},
  ];

  void addContact(String name, String phone) {
    setState(() {
      contacts.add({"name": name, "phone": phone});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Manager")),

      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(contacts[index]["name"]!),
            subtitle: Text(contacts[index]["phone"]!),

            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Contact Details"),
                  content: Text(
                    "Name: ${contacts[index]["name"]}\nPhone: ${contacts[index]["phone"]}",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newContact = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddContactPage()),
          );

          if (newContact != null) {
            addContact(newContact["name"], newContact["phone"]);
          }
        },
      ),
    );
  }
}
