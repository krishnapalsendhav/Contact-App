import 'package:alison/data/contact.dart';
import 'package:alison/ui/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  final Contact? editedContact;
  final int? editedContactIndex;
  const ContactForm({Key? key, this.editedContact, this.editedContactIndex})
      : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _phoneNumber;
  bool get isEditMode => widget.editedContact != null;
  //Validating Name
  String? _validatorName(value) {
    if (value!.isEmpty) {
      return 'Enter your Name';
    } else {
      return null;
    }
  }

  //ValidATRING Email
  String? _validatorEmail(value) {
    final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (value!.isEmpty) {
      return 'Enter your Email Address';
    } else if (!regex.hasMatch(value)) {
      return "Enter Correct Email Address";
    } else {
      return null;
    }
  }

//Valedating Phone Number
  String? _validatorPhoneNumber(value) {
    final regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(9),
              child: TextFormField(
                validator: _validatorName,
                initialValue: widget.editedContact?.name,
                keyboardType: TextInputType.name,
                onSaved: (value) => _name = value,
                decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(9),
              child: TextFormField(
                onSaved: (value) => _email = value?.toLowerCase(),
                keyboardType: TextInputType.emailAddress,
                validator: _validatorEmail,
                initialValue: widget.editedContact?.email,
                decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(9),
              child: TextFormField(
                onSaved: (value) => _phoneNumber = value,
                validator: _validatorPhoneNumber,
                initialValue: widget.editedContact?.phoneNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Phone Number',
                  prefixIcon: const Icon(Icons.numbers),
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: ElevatedButton(
                    onPressed: () => _onSavedContactButtonPressed(),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 20),
                    )))
          ],
        ));
  }

  void _onSavedContactButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final newContact = Contact(
          name: _name!,
          email: _email!,
          phoneNumber: _phoneNumber!,
          isFavorite: widget.editedContact?.isFavorite ?? false);
      if (isEditMode) {
        ScopedModel.of<ContactsModel>(context)
            .editContact(newContact, widget.editedContactIndex!);
      } else {
        ScopedModel.of<ContactsModel>(context).addContact(newContact);
      }
      Navigator.pop(context);
    }
  }
}
