import 'package:alison/ui/contact_list/contact_list_page.dart';
import 'package:alison/ui/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // *This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ContactsModel()..loadContact(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const ContactListPage(),
      ),
    );
  }
}
