import 'package:alison/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactCreatePage extends StatelessWidget {
  const ContactCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Create"),
      ),
      body: const ContactForm(),
    );
  }
}
