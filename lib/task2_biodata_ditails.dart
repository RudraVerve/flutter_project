import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biodata app',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // Checkbox variables.
  bool ch_12th= false;
  bool ch_10th= false;
  bool ch_graduation=false;
  bool ch_pg=false;

  // Display education.
  String ed_10th='NA';
  String ed_12th='NA';
  String ed_graduation='NA';
  String ed_pg='NA';

  // Container open variable.
  bool isOpen=false;

  // Radio box variable.
  String gender='not Selected';

  // TextField input variables.
  final my_name = TextEditingController();
  final my_mail = TextEditingController();
  final my_addres = TextEditingController();

  // Print TextField input variables.
  String name='';
  String mail='';
  String addres='';

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  void _press(){
    setState(() {
      isOpen=!isOpen;
    });
  }

  void _data(){
    setState(() {
      name=my_name.text;
      mail=my_mail.text;
      addres=my_addres.text;
    });
  }

  // Email validation function
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

  // Mobile number validation function
  String? validateMobile(String? value) {
    const mobilePattern = r'^\+?\d{10,12}$'; // Simple pattern to validate mobile numbers
    final regExp = RegExp(mobilePattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Biodata'),
      ),
      body: Form(
        key: _formKey, // Assign the form key
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: my_name,
                          decoration: InputDecoration(
                            hintText: 'Enter your full name',
                            suffixIcon: Icon(Icons.account_circle, color: Colors.cyan),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 6
                                )
                            ),
                          ),
                          // Optional: Add name validation if required
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: my_mail,
                          decoration: InputDecoration(
                            hintText: 'Enter your Email ID',
                            suffixIcon: Icon(Icons.mail_sharp, color: Colors.cyan),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 6
                                )
                            ),
                          ),
                          validator: validateEmail, // Use email validation
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: my_addres,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: 'Enter your Mobile no.',
                            suffixIcon: Icon(Icons.phone, color: Colors.cyan), // Changed icon to phone
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 6
                                )
                            ),
                          ),
                          validator: validateMobile, // Use mobile number validation
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Select any one'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: RadioMenuButton(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (selected_value) {
                              setState(() {
                                gender = selected_value!;
                              });
                            },
                            child: Text('Male'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: RadioMenuButton(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (selected_value) {
                              setState(() {
                                gender = selected_value!;
                              });
                            },
                            child: Text('Female'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: RadioMenuButton(
                            value: 'Other',
                            groupValue: gender,
                            onChanged: (selected_value) {
                              setState(() {
                                gender = selected_value!;
                              });
                            },
                            child: Text('Other'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Select your education"),
                      CheckboxListTile(
                          title: Text('10th'),
                          value: ch_10th,
                          onChanged: (val) {
                            setState(() {
                              ch_10th = val!;
                              ed_10th = ch_10th ? 'YES' : 'NA';
                            });
                          }
                      ),
                      CheckboxListTile(
                          title: Text('12th'),
                          value: ch_12th,
                          onChanged: (val) {
                            setState(() {
                              ch_12th = val!;
                              ed_12th = ch_12th ? 'YES' : 'NA';
                            });
                          }
                      ),
                      CheckboxListTile(
                          title: Text('Graduation'),
                          value: ch_graduation,
                          onChanged: (val) {
                            setState(() {
                              ch_graduation = val!;
                              ed_graduation = ch_graduation ? 'YES' : 'NA';
                            });
                          }
                      ),
                      CheckboxListTile(
                          title: Text('Post Graduation'),
                          value: ch_pg,
                          onChanged: (val) {
                            setState(() {
                              ch_pg = val!;
                              ed_pg = ch_pg ? 'YES' : 'NA';
                            });
                          }
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: Text('View Details'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // If the form is valid, proceed
                  _press();
                  _data();
                } else {
                  // If the form is not valid, display an error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please fix the errors')
                    ),
                  );
                }
              },
            ),
            if (isOpen) Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name : $name', style: TextStyle(fontSize: 20)),
                  Text('Email : $mail', style: TextStyle(fontSize: 20)),
                  Text('Mobile no. : $addres', style: TextStyle(fontSize: 20)),
                  Text('Gender : $gender', style: TextStyle(fontSize: 20)),
                  Text('10th : $ed_10th', style: TextStyle(fontSize: 20)),
                  Text('12th : $ed_12th', style: TextStyle(fontSize: 20)),
                  Text('Graduation : $ed_graduation', style: TextStyle(fontSize: 20)),
                  Text('Post Graduation : $ed_pg', style: TextStyle(fontSize: 20)),
                ],
              ),
            ) else Container(),
          ],
        ),
      ),
    );
  }
}
