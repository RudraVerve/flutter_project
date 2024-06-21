import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app_rudra/db/db_helping.dart';
import 'db/dataviewer.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized(); //used to remove the status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); //used to remove the status bar
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //cupertinoapp
      title: 'Flutter Demo',
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

  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController addressInputController = TextEditingController();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController facebookurlController = TextEditingController();
  TextEditingController instaurlController = TextEditingController();
  TextEditingController tuterurlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool isMale = true;

   void clearForm(){
     emailInputController.clear();
     passwordInputController.clear();
     phoneInputController.clear();
     addressInputController.clear();
     nameInputController.clear();
   }

  void flipGender() {
    setState(() {
      isMale = !isMale;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
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

  String? validatePassword(String? value) {
    if (value == null || value.length < 6 ) {
      return 'Password must be between 6 to 8 characters';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    return null;
  }

  void _showFacebookUrlDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Facebook URL'),
          content: TextFormField(
            controller: facebookurlController,
            decoration: InputDecoration(
              hintText: 'Enter Facebook URL',
            ),
            keyboardType: TextInputType.url,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without action
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Retrieve the URL and perform any necessary actions
                String url = facebookurlController.text;
                Navigator.of(context).pop(); // Close the dialog
                // Perform further actions with the URL if needed
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  } //fopr the facebook avatar
  void _showInstaUrlDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Insta URL'),
          content: TextFormField(
            controller: instaurlController,
            decoration: InputDecoration(
              hintText: 'Enter Insta URL',
            ),
            keyboardType: TextInputType.url,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without action
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Retrieve the URL and perform any necessary actions
                String url = instaurlController.text;
                Navigator.of(context).pop(); // Close the dialog
                // Perform further actions with the URL if needed
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  } //fopr the insta avatar
  void _showTuterUrlDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Tuter URL'),
          content: TextFormField(
            controller: tuterurlController,
            decoration: InputDecoration(
              hintText: 'Enter Tuter URL',
            ),
            keyboardType: TextInputType.url,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without action
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Retrieve the URL and perform any necessary actions
                String url = tuterurlController.text;
                Navigator.of(context).pop(); // Close the dialog
                // Perform further actions with the URL if needed
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  } //fopr the tuter avatar
  void _showErrorSubmitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { // Renamed to avoid confusion
        return AlertDialog(
          backgroundColor: Colors.lightGreenAccent,
          title: Text('Something went wrong',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
          content: Text('An unexpected error has occurred. Plese Fix the Error or try again later.',style: TextStyle(fontSize: 18),), // Added content
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Use dialogContext to close the dialog
              },
              child: Text('Cancel',style: TextStyle(fontSize: 20),),
            ),
          ],
        );
      },
    );
  } // for the error subbmit massage
  void _showErrormobDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) { // Renamed to avoid confusion
        return AlertDialog(
          backgroundColor: Colors.lightGreenAccent,
          title: Text('Mobile number Allrady Exist',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600),),
          content: Text('The mobile number is alrady Exist Plese use a deferent one or try again later.',style: TextStyle(fontSize: 18),), // Added content
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Use dialogContext to close the dialog
              },
              child: Text('Cancel',style: TextStyle(fontSize: 20),),
            ),
          ],
        );
      },
    );
  }//mobile no.alrady exist

  final dbhelper=db_helper.instance;

  void insertquery() async{
    Map<String, dynamic> row={
      db_helper.c_name : nameInputController.text,
      db_helper.c_email : emailInputController.text,
      db_helper.c_pass : passwordInputController.text,
      db_helper.c_address : addressInputController.text,
      db_helper.c_mobile : phoneInputController.text,
      db_helper.c_gender : isMale ? 'Male':'Female',
      db_helper.c_facbook : facebookurlController.text.isNotEmpty ? facebookurlController.text : 'Not avalable',
      db_helper.c_insta : instaurlController.text.isNotEmpty ? instaurlController.text : 'Not avalable',
      db_helper.c_tuiter : tuterurlController.text.isNotEmpty ? tuterurlController.text : 'Not avalable',
    };
    final id= await dbhelper.insert(row);
    if(id==-1){
      _showErrormobDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView(
          children:[
            Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.withOpacity(0.5),
                  Colors.orange.withOpacity(0.8),
                  Colors.pink.withOpacity(0.8),
                  Colors.deepPurpleAccent.withOpacity(0.5),
                ],
              ),//used to give multilpe colour
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            isMale ? 'assets/image/boy1.png' : 'assets/image/girl2.png',
                          ),
                          radius: 30,
                        ),
                      ),//male, female avatar
                      ElevatedButton(
                        child: Text(isMale ? 'Male' : 'Female'),
                        onPressed: flipGender,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailInputController,
                          validator: validateEmail,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            hintText: 'Enter your Email ID',
                            suffixIcon: Icon(Icons.mail_sharp, color: Colors.cyan),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0, // Increase the border width here
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                          // validator: validateEmail, // Use email validation
                        ),
                      ),//email field
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordInputController,
                          validator: validatePassword,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.cyan,
                              ),
                              onPressed: togglePasswordVisibility,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),//password field
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameInputController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            hintText: 'Enter your Name',
                            suffixIcon: Icon(Icons.person, color: Colors.cyan),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 6
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                          // validator: validateEmail, // Use email validation
                        ),
                      ),// name field
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          controller: addressInputController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            hintText: 'Enter your Address',
                            suffixIcon: Icon(Icons.home, color: Colors.cyan),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 6
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                          // validator: validateEmail, // Use email validation
                        ),
                      ),//address field
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: phoneInputController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            hintText: 'Enter your Mobile number',
                            suffixIcon: Icon(Icons.phone, color: Colors.cyan),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 6
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                          // validator: validateEmail, // Use email validation
                        ),
                      ),// mobile no. field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if ((_formKey.currentState?.validate() ?? false) && nameInputController.text.isNotEmpty && addressInputController.text.isNotEmpty && phoneInputController.text.isNotEmpty) {
                                  insertquery();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('data added successfully')),
                                  );
                                  clearForm();
                                } else {
                                  _showErrorSubmitDialog(context);
                                }

                              },
                              child: Text('Submit',style: TextStyle(fontFamily: 'GooglFont',fontSize: 25,fontWeight: FontWeight.w600),),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 40), // Set the width and height of the button
                                shadowColor: Colors.black,  // Set the shadow color to green
                                elevation:12,              // Increase the elevation for a more pronounced shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20), // Set the border radius to 20
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DataViewer()),
                                );
                              },
                              child: Text('Details',style: TextStyle(fontFamily: 'GooglFont',fontSize: 25,fontWeight: FontWeight.w600),),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 40), // Set the width and height of the button
                                shadowColor: Colors.black,  // Set the shadow color to green
                                elevation:12,              // Increase the elevation for a more pronounced shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20), // Set the border radius to 20
                                ),
                              ),
                            ),
                          )
                        ],
                      ),// buttons(submit, details)
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (){
                                      _showFacebookUrlDialog(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: const AssetImage('assets/image/facebook.png'),
                                      radius: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (){
                                      _showInstaUrlDialog(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: const AssetImage('assets/image/insta.png'),
                                      radius: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (){
                                      _showTuterUrlDialog(context);
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: const AssetImage('assets/image/tuit.png'),
                                      radius: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),//facebook, insta, tutier avatar
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]
        )

    );
  }
}



