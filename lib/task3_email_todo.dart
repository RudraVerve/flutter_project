import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  List<String> emailItems = [];
  TextEditingController emailInputController = TextEditingController();
  List<TextEditingController> emailControllers = [];

  @override
  void initState() {
    super.initState();
  }

  void _addEmailItem() {
    if (emailInputController.text.isNotEmpty) {
      setState(() {
        if (emailItems.contains(emailInputController.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Id Already Exists')),
          );
        } else {
          emailItems.add(emailInputController.text);
          emailControllers.add(TextEditingController(text: emailInputController.text));
          emailInputController.clear();
        }
      });
    }
  }

  String? validateEmail(String? value) {
    const emailPattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    final regExp = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void dispose() {
    emailInputController.dispose();
    for (var controller in emailControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: emailInputController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.mail_sharp, color: Colors.cyan),
                        hintText: 'Enter your email Id',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    child: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _addEmailItem();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fix the errors')),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: emailItems.isEmpty
                  ? const Center(child: Text('No email items added.'))
                  : ListView.separated(
                itemBuilder: (context, index) {
                  return EmailListItem(
                    index: index,
                    email: emailItems[index],
                    onEmailUpdate: (updatedEmail) {
                      if (validateEmail(updatedEmail) == null) {
                        setState(() {
                          emailItems[index] = updatedEmail;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid email address')),
                        );
                      }
                    },
                    onDelete: () {
                      setState(() {
                        emailItems.removeAt(index);
                        emailControllers.removeAt(index);
                      });
                    },
                  );
                },
                itemCount: emailItems.length,
                separatorBuilder: (context, index) {
                  return const Divider(height: 15, thickness: 1);
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: emailItems.isEmpty
                    ? const Center(
                  child: Text(
                    "There is no email in the list",
                    style: TextStyle(fontSize: 20),
                  ),
                )
                    : ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        emailItems[index],
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  },
                  itemCount: emailItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailListItem extends StatefulWidget {
  final int index;
  final String email;
  final ValueChanged<String> onEmailUpdate;
  final VoidCallback onDelete;

  const EmailListItem({
    Key? key,
    required this.index,
    required this.email,
    required this.onEmailUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  _EmailListItemState createState() => _EmailListItemState();
}

class _EmailListItemState extends State<EmailListItem> {
  late TextEditingController _emailController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _updateEmail() {
    widget.onEmailUpdate(_emailController.text);
    _toggleEdit();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${widget.index + 1}'),
      title: _isEditing
          ? TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: 'Edit your email Id',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
        ),
      )
          : Text(widget.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.done, color: Colors.green),
              onPressed: _updateEmail,
            )
          else
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: _toggleEdit,
            ),
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.red),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}
