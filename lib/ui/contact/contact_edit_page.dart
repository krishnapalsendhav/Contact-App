import 'package:alison/data/contact.dart';
import 'package:alison/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactEditPage extends StatelessWidget {
  final Contact editedContact;
  final int editedContactIndex;
  const ContactEditPage(
      {Key? key, required this.editedContact, required this.editedContactIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
      ),
      body: ContactForm(
        editedContact: editedContact,
        editedContactIndex: editedContactIndex,
      ),
    );
  }
}
