import 'package:alison/ui/model/contact_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  var fake = Faker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Center(
          child: Icon(Icons.plus_one_rounded),
        ),
      ),
      appBar: AppBar(
        title: const Text("Contact"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort_by_alpha_rounded),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.abc))
        ],
      ),
      drawer: const Drawer(),
      body: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          return ListView.builder(
              itemCount: model.contacts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(
                          -1.0,
                          -1.0,
                        ),
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text(model.contacts[index].name),
                    subtitle: Text(model.contacts[index].phoneNumber),
                    leading: CircleAvatar(
                      child: Text(
                        model.contacts[index].name.substring(0, 1),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        model.changeFavoriteStatus(index);
                      },
                      icon: Icon(
                        model.contacts[index].isFavorite
                            ? Icons.star
                            : Icons.star_border,
                        color: model.contacts[index].isFavorite
                            ? Colors.purple
                            : Colors.grey,
                        // Icons.safety_check,
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

// ignore: must_be_immutable

