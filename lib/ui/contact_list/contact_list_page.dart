import 'package:alison/data/contact.dart';
import 'package:alison/ui/contact/contact_create.dart';
import 'package:alison/ui/contact/contact_edit_page.dart';
import 'package:alison/ui/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactCreatePage()),
          );
        },
        child: const Center(
          child: Icon(
            Icons.person_add_alt_rounded,
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          if (model.isloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: model.contacts.length,
                itemBuilder: (context, index) {
                  final displayedContact = model.contacts[index];
                  Future<void> callToNumber(context) async {
                    await FlutterPhoneDirectCaller.callNumber(
                        model.contacts[index].phoneNumber);
                  }

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
                    child: _buildSlidable(
                        callToNumber, model, index, context, displayedContact),
                  );
                });
          }
        },
      ),
    );
  }

  Slidable _buildSlidable(
      Future<void> Function(dynamic context) callToNumber,
      ContactsModel model,
      int index,
      BuildContext context,
      Contact displayedContact) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: callToNumber,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.call,
            label: 'Call',
          ),
          // const SlidableAction(
          //   onPressed: null,
          //   backgroundColor: Color(0xFF21B7CA),
          //   foregroundColor: Colors.white,
          //   icon: Icons.message_rounded,
          //   label: 'Message',
          // ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              model.deleteContact(displayedContact);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          // SlidableAction(
          //   onPressed: (context) {

          //   },
          //   backgroundColor: Colors.yellowAccent,
          //   foregroundColor: Colors.white,
          //   icon: Icons.edit,
          //   label: 'Edit',
          // ),
        ],
      ),
      child: _buildTile(model, index, context, displayedContact),
    );
  }

  ListTile _buildTile(ContactsModel model, int index, BuildContext context,
      Contact displayedContact) {
    return ListTile(
      title: Text(model.contacts[index].name),
      subtitle: Text(model.contacts[index].phoneNumber),
      onTap: (() => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactEditPage(
                      editedContact: displayedContact,
                      editedContactIndex: index,
                    )),
          )),
      leading: CircleAvatar(
        child: _buildCircleAvatar(model, index),
      ),
      trailing: IconButton(
        onPressed: () {
          model.changeFavoriteStatus(displayedContact);
        },
        icon: Icon(
          model.contacts[index].isFavorite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          color: model.contacts[index].isFavorite ? Colors.purple : Colors.grey,
          // Icons.safety_check,
        ),
      ),
    );
  }

  Widget _buildCircleAvatar(ContactsModel model, int index) {
    if (model.contacts[index].imageFile == null) {
      return Text(
        model.contacts[index].name[0],
        style: const TextStyle(color: Colors.white, fontSize: 18),
      );
    } else {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(
            model.contacts[index].imageFile!,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
