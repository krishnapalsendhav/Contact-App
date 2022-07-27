import 'package:alison/data/contact.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContactListPage extends StatelessWidget {
  var fake = Faker();
  final List<Contact> _contact = List.generate(100, (index) {
    return Contact(
      name: "${faker.person.firstName()} ${faker.person.lastName()}",
      email: faker.internet.email(),
      phoneNumber: faker.randomGenerator.integer(3999999999).toString(),
    );
  });

  ContactListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
      ),
      body: ListView.builder(
          itemCount: _contact.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_contact[index].name),
              subtitle: Text(_contact[index].phoneNumber),
              leading: CircleAvatar(
                child: Text(
                  _contact[index].name.substring(0, 1),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  var name = _contact[index].name;
                  final snackBar = SnackBar(
                    content: Text('Calling to $name'),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: const Icon(
                  Icons.call,
                  size: 28,
                  color: Colors.purple,
                ),
              ),
            );
          }),
    );
  }
}
