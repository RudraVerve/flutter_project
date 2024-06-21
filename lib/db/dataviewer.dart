import 'package:flutter/material.dart';
import 'package:my_app_rudra/db/db_helping.dart';

class DataViewer extends StatefulWidget {
  @override
  _DataViewerState createState() => _DataViewerState();
}

class _DataViewerState extends State<DataViewer> {
  final dbhelper = db_helper.instance;
  List<Map<String, dynamic>> rows = [];

  @override
  void initState() {
    super.initState();
    fetchRows();
  }

  Future<void> fetchRows() async {
    try {
      rows = await dbhelper.queryall();
      setState(() {});
      print("Fetched rows: $rows");
    } catch (e) {
      print("Error fetching rows: $e");
    }
  }

  Future<void> deleteDatabaseAlldata() async {
    try {
      await dbhelper.deleteDatabaseAlldata();
      setState(() {
        rows.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Database deleted successfully!')),
      );
    } catch (e) {
      print("Error deleting database: $e");
    }
  }

  Future<void> deleteSpacific(int id) async {
    try {
      await dbhelper.deleteSpacific(id);
      setState(() {
        fetchRows();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record deleted successfully!')),
      );
    } catch (e) {
      print("Error deleting record: $e");
    }
  }

  Future<void> updateSpacificc(int id, String email, String name, String Address, String Mob) async {
    try {
      await dbhelper.updateSpacific(id, email, name, Address, Mob);
      setState(() {
        fetchRows();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record Update successfully!')),
      );
    } catch (e) {
      print("Error deleting record: $e");
    }
  }

  void _showWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.lightGreenAccent,
          title: Text(
            'Warning',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Do you want to delete all the data?',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel', style: TextStyle(fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                deleteDatabaseAlldata();
                Navigator.of(dialogContext).pop();
              },
              child: Text('Yes', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              _showWarning(context);
            },
          ),
        ],
      ),
      body: rows.isEmpty
          ? Center(
        child: Text('No data available'),
      )
          : Container(
            child: ListView.separated(
            itemCount: rows.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
                height: 25,
                thickness: 4,
            ),
            itemBuilder: (BuildContext context, int index) {
            final row = rows[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${row[db_helper.c_id]}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Name: ${row[db_helper.c_name]}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Email: ${row[db_helper.c_email]}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Mobile: ${row[db_helper.c_mobile]}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                // Initialize controllers with current values
                                TextEditingController editemailInputController = TextEditingController(text: row[db_helper.c_email]);
                                TextEditingController editnameInputController = TextEditingController(text: row[db_helper.c_name]);
                                TextEditingController editaddressInputController = TextEditingController(text: row[db_helper.c_address]);
                                TextEditingController editphoneInputController = TextEditingController(text: row[db_helper.c_mobile]);

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

                                final _formKeys = GlobalKey<FormState>();

                                return AlertDialog(
                                  backgroundColor: Colors.lightGreenAccent,
                                  title: Text(
                                    'Update the Row',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Form(
                                      key: _formKeys,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType: TextInputType.emailAddress,
                                              controller: editemailInputController,
                                              validator: validateEmail,
                                              decoration: InputDecoration(
                                                filled: true,
                                                hintText: 'Enter your Email ID',
                                                suffixIcon: Icon(
                                                  Icons.mail_sharp,
                                                  color: Colors.cyan,
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType: TextInputType.name,
                                              controller: editnameInputController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                hintText: 'Enter your Name',
                                                suffixIcon: Icon(
                                                  Icons.person,
                                                  color: Colors.cyan,
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              keyboardType: TextInputType.streetAddress,
                                              controller: editaddressInputController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                hintText: 'Enter your Address',
                                                suffixIcon: Icon(
                                                  Icons.home,
                                                  color: Colors.cyan,
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: editphoneInputController,
                                              keyboardType: TextInputType.phone,
                                              maxLength: 10,
                                              decoration: InputDecoration(
                                                filled: true,
                                                hintText: 'Enter your Mobile number',
                                                suffixIcon: Icon(
                                                  Icons.phone,
                                                  color: Colors.cyan,
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (_formKeys.currentState!.validate()) {
                                          updateSpacificc(row[db_helper.c_id],editemailInputController.text,editnameInputController.text,editaddressInputController.text,editphoneInputController.text);
                                          Navigator.of(dialogContext).pop();
                                        }
                                      },
                                      child: Text(
                                        'Update',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  backgroundColor: Colors.lightGreenAccent,
                                  title: Text(
                                    'Warning',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    'Do you want to delete this row?',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteSpacific(row[db_helper.c_id]);
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
        },
      ),
      ),
    );
  }
}