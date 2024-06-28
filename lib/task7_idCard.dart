import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:my_app_rudra/task7_id_db_helper/db_helper.dart';
import 'package:my_app_rudra/task7_id_db_helper/insert_data.dart';
import 'package:my_app_rudra/task7_id_db_helper/list_of_ids.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

  void clearForm() {
    collageController.clear();
    nameController.clear();
    rollController.clear();
    domenController.clear();
    dobController.clear();
  }

  Future<void> _insert(Uint8List imageBytes, Uint8List imageBytes2) async {
    var obj = insert_data(
      name: nameController.text,
      colage: collageController.text,
      roll: rollController.text,
      domen: domenController.text,
      dob: dobController.text,
    );
    final id = await dbhelper.insert(obj, obj.roll!, imageBytes, imageBytes2);
    if (id == -1) {
      _UniqueRollDialog();
      print("Not inserted");
    } else {
      print("Inserted successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Record Added successfully!')),
      );
    }
  }
  Future<void> _pickAndStoreImage(Uint8List imageBytesQr) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        Uint8List imageBytes = await pickedFile.readAsBytes();
        _insert(imageBytes, imageBytesQr);
        clearForm();
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
  Future<void> generateAndStoreQrCode(String data) async {
    if(data.isEmpty){
      setState(() {
        data = "NO DATA FOUND";
      });
    }
    final qrValidationResult = QrValidator.validate(
      data: data,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: qrCode!,
        color: Colors.pink, //QR CODE COLOR
        gapless: true,
      );
      final image = await painter.toImage(300);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final imageBytes = byteData!.buffer.asUint8List();
      await _pickAndStoreImage(imageBytes);
    } else {
      print("Invalid QR code data");
    }
  }

  void _UniqueRollDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Error', style: TextStyle(color: Colors.redAccent)),
          content: const Text('The Student already exists. The Roll Number must be unique'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
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
          title: const Text('Error', style: TextStyle(color: Colors.redAccent)),
          content: const Text('You must fill in all the fields'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _AddMoreDetailsDialog()async{
    showDialog(context: context, builder: (BuildContext dialogContext){
      TextEditingController allDetailsController = TextEditingController();
      return AlertDialog(
        title:Text('Add More Details About Student For QR'),
        content:TextField(
          controller: allDetailsController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Enter All details separeted with ,',
            suffixIcon: Icon(
              Icons.details,
              color: Colors.cyan,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: ()async{
            Navigator.of(context).pop();
            await generateAndStoreQrCode(allDetailsController.text);
            }, child: Text('NO')
          ),
          TextButton(onPressed: ()async{
            Navigator.of(context).pop();
            setState(() {
              allDetailsController.clear();
            });
            await generateAndStoreQrCode(allDetailsController.text);
          }, child:Text('ADD'))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
              ),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'ID Card Generator',
                      style: TextStyle(fontFamily: 'LibreBaskerville', fontSize: 25),
                    ),
                  ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: collageController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            hintText: 'Enter your College Name',
                            suffixIcon: const Icon(Icons.school, color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
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
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            hintText: 'Enter your Name',
                            suffixIcon: const Icon(Icons.person_outline, color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
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
                            suffixIcon: const Icon(Icons.ac_unit, color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
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
                            hintText: 'Enter your Domain',
                            suffixIcon: const Icon(Icons.workspaces_filled, color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
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
                            hintText: 'Enter your DOB: DD/MM/YYYY',
                            suffixIcon: const Icon(Icons.date_range, color: Colors.cyan),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
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
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              collageController.text.isNotEmpty &&
                              rollController.text.isNotEmpty &&
                              domenController.text.isNotEmpty &&
                              dobController.text.isNotEmpty) {
                            _AddMoreDetailsDialog();
                          } else {
                            _ErrorfieldDialog();
                          }
                        },
                        child: const Text('Generate'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40),
                          shadowColor: Colors.black,
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const IdList(),
                            ),
                          );
                        },
                        child: const Text('View ID Card'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(150, 40),
                          shadowColor: Colors.black,
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome To',
                    style: TextStyle(
                      fontFamily: 'PlaywriteMX',
                      fontSize: 30,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Text(
                  'ID Card Generator',
                  style: TextStyle(
                    fontFamily: 'PlaywriteMX',
                    fontSize: 35,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}