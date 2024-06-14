import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../task5_login_form.dart';

class  FormPage extends StatefulWidget {
   FormPage ({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  bool chack = false;
  bool avatar = true;
  String gender = 'Male';
  bool showPassword = false;


  final _formKey = GlobalKey<FormState>();

   TextEditingController emailInputController = TextEditingController();
   TextEditingController passwordInputController = TextEditingController();

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
     // Password should be between 6 to 8 characters
     if (value == null || value.length < 6 || value.length > 8) {
       return 'Password must be between 6 to 8 characters';
     }

     // Password should contain at least one special character
     if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
       return 'Password must contain at least one special character';
     }

     // Password should contain at least one uppercase letter
     if (!value.contains(RegExp(r'[A-Z]'))) {
       return 'Password must contain at least one uppercase letter';
     }

     // If all conditions are met, return null (no error)
     return null;
   }

   void togglePasswordVisibility() {
     setState(() {
       showPassword = !showPassword;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
      body: Container(
        margin: const EdgeInsets.all(20.0),
        height: 300, // Increased height to avoid clipping
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('assets/image/login.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          key: _formKey, // Form key to manage state
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: emailInputController,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email ID',
                      suffixIcon: const Icon(Icons.mail_sharp,color: Colors.blue,),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordInputController,
                  validator: validatePassword,
                  obscureText: !showPassword, // Toggle obscureText based on showPassword state
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onPressed: togglePasswordVisibility,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Checkbox(
                      value: chack,
                      onChanged: (bool? value) {
                        setState(() {
                          chack = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.blue;
                        }
                        return Colors.white;
                      }),
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                  ),
                  const Text(
                    'Remind me',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: TextButton(
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('This functionality will be added soon')),
                        );
                      },
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fix the errors')),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
