import 'package:flutter/material.dart';
import 'package:fast_contacts/fast_contacts.dart';

class PhoneBookView extends StatefulWidget {
  const PhoneBookView({Key? key}) : super(key: key);

  @override
  State<PhoneBookView> createState() => _PhoneBookViewState();
}

class _PhoneBookViewState extends State<PhoneBookView> {
  late List<Contact> contacts;
  late List<Contact> filteredContacts;
  final tController = TextEditingController();

  getContacts() async {
    contacts = await FastContacts.allContacts;
    filteredContacts = contacts;
  }

  searchContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredContacts = contacts;
      } else {
        filteredContacts = contacts
            .where((contact) => contact.displayName
                .toLowerCase()
                .contains(query.trim().toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    tController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filteredContacts = List.empty();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Контакты")),
        body: Column(children: [
          TextField(
            controller: tController,
            onChanged: (String input) {
              searchContacts(input);
            },
            decoration: const InputDecoration(
                labelText: "Поиск", prefixIcon: Icon(Icons.search)),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: filteredContacts.length,
            itemBuilder: (context, index) {
              Contact contact = filteredContacts[index];
              return ContactListTile(
                  name: (contact.displayName),
                  phone: (contact.phones.isNotEmpty ? contact.phones[0] : null),
                  email:
                      (contact.emails.isNotEmpty ? contact.emails[0] : null));
            },
          ))
        ]));
  }
}

class ContactListTile extends StatelessWidget {
  final String? name;
  final String? phone;
  final String? email;

  const ContactListTile({Key? key, this.name, this.phone, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        isThreeLine: true,
        title: Text(
          name != null ? name.toString() : '',
          style: const TextStyle(fontSize: 18),
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(phone != null ? phone.toString() : ''),
          Text(email != null ? email.toString() : '')
        ]));
  }
}
