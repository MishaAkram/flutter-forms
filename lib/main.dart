import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTittle = "Form Validation Demo";
    return MaterialApp(
        title: appTittle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(appTittle),
          ),
          body: MyCustomForm(),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _myController = TextEditingController();
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    _myController.addListener(_printLatestValues);
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _myController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  void _printLatestValues() {
    print("second text fields: ${_myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "enter your age",
                  ),),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter some text";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // hintText: "Enter a search term",
                  labelText: "Enter your username",
                ),
                onChanged: (text) {
                  print('First text field: $text');
                },
                controller: _myController,
                focusNode: myFocusNode,
              ),
              
            ]),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Processing Data")));
                  }
                },
                child: Text("Submit"),
              )),
          FloatingActionButton(
            onPressed: () => myFocusNode.requestFocus(),
            tooltip: 'Focus second text field',
            child: Icon(Icons.edit),
          )
        ],
      ),
    );
  }
}
