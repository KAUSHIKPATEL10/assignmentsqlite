import 'package:assignmentsqlite/models/note.dart';
import 'package:assignmentsqlite/screens/home/home.dart';
import 'package:flutter/material.dart';

import '../../services/sqlite_service.dart';

class AddEditNote extends StatefulWidget {
  const AddEditNote({Key? key}) : super(key: key);

  @override
  _AddEditNoteState createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(247, 250, 252, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(94, 114, 228, 1.0),
          elevation: 0.0,
          title: const Text('Add or edit a note'),
        ),
        body: const MyCustomForm());
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late String desc, title;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Title';
            }
            return null;
          }, onChanged: (value) {
            setState(() {
              title = value;
            });
          }),
          TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some Description';
            }
            return null;
          }, onChanged: (value) {
            setState(() {
              desc = value;
            });
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {

                setState(() {
                  if (_formKey.currentState!.validate()) {
                    // In the real world,
                    // you'd often call a server or save the information in a database.

                    Note n = Note(
                      title: title,
                      description: desc,
                      id: "001",
                    );
                    SqliteService.createItem(n);
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );


                });
                // Validate returns true if the form is valid, or false otherwise.

              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
