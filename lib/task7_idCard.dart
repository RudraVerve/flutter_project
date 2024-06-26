import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app_rudra/task7_id_db_helper/db_helper.dart';
import 'package:my_app_rudra/task7_id_db_helper/insert_data.dart';
import 'package:my_app_rudra/task7_id_db_helper/list_of_ids.dart';
// import 'package:my_app_rudra/task7_id_db_helper/view_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  final _key = GlobalKey<FormState>();

  TextEditingController collageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController domenController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController idController = TextEditingController();

  final dbhelper = db_helper.instance;
  List<Map<String, dynamic>> rows = [];

  String? roll;
  String? name;
  String? collage;
  String? domen;
  String? dob;
  String? rollno;

  @override
  void initState() {
    super.initState();
  }

  void clearForm(){
    collageController.clear();
    nameController.clear();
    rollController.clear();
    domenController.clear();
    dobController.clear();
  }

  //database code/methord
  void _insert(){
    var obj =  insert_data(
      name: nameController.text,
      colage:collageController.text,
      roll:rollController.text,
      domen:domenController.text,
      dob:dobController.text
    );
    Future<void> insertquery() async {
      final dbhelper = db_helper.instance;
      final id = await dbhelper.insert(obj, obj.roll!);
      if (id == -1) {
        _UniqueRollDialog();
        print("not insart");
      }
      else{
        print("sucessfull");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Record Added successfully!')),
        );
      }
    }
    insertquery();
  }

  //Dialog code/methord
  void _UniqueRollDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Error',style: TextStyle(color: Colors.redAccent),),
          content: Text('The Student Alrady Exist, The Roll Number Most Be Unique'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void _ErrorfieldDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Error',style: TextStyle(color: Colors.redAccent),),
          content: Text('You Most Have To Fill All The Field'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.pinkAccent.withOpacity(0.5),
                    Colors.deepPurpleAccent.withOpacity(0.8),
                    Colors.grey.withOpacity(0.8),
                    Colors.black.withOpacity(0.8),
                  ],
                ),//used to give multilpe colour
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('Id Card Generator',style: TextStyle(fontFamily:'LibreBaskerville',fontSize: 25),),
                    ),
                  ),
                  Form(
                    key: _key,
                    child:Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: collageController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              hintText: 'Enter your Collage Name',
                              suffixIcon: Icon(Icons.school, color: Colors.cyan),
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              hintText: 'Enter your Name',
                              suffixIcon: Icon(Icons.person_outline, color: Colors.cyan),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: rollController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              hintText: 'Enter your Roll no.',
                              suffixIcon: Icon(Icons.ac_unit, color: Colors.cyan),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: domenController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              hintText: 'Enter your Domen',
                              suffixIcon: Icon(Icons.workspaces_filled, color: Colors.cyan),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: dobController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              hintText: 'Enter your DOB :- DD/MM/YYYY',
                              suffixIcon: Icon(Icons.date_range, color: Colors.cyan),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            if(nameController.text.isNotEmpty && collageController.text.isNotEmpty && rollController.text.isNotEmpty && domenController.text.isNotEmpty && domenController.text.isNotEmpty){
                              _insert();
                              clearForm();
                            }
                            else{
                              _ErrorfieldDialog();
                            }
                          },
                          child: Text('Generate'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 40),
                            shadowColor: Colors.black,
                            elevation:12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IdList(),
                              ),
                            );
                          },
                          child: Text('View Id Card'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(150, 40),
                            shadowColor: Colors.black,
                            elevation:12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Well Come To',style: TextStyle(fontFamily: 'PlaywriteMX',fontSize: 30,color: Colors.pinkAccent,fontWeight: FontWeight.w600),),
                  ),
                  Text('id Card generator',
                    style: TextStyle(
                      fontFamily: 'PlaywriteMX',
                      fontSize: 35,
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w600,),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
