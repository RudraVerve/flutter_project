import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'IdCardDisplay.dart';
import 'db_helper.dart';
import 'insert_data.dart';

class IdList extends StatefulWidget {
  const IdList({super.key});
  @override
  State<IdList> createState() => _IdListState();
}

class _IdListState extends State<IdList> {

  TextEditingController rollController1 = TextEditingController();
  final dbhelper = db_helper.instance;
  List<Map<String, dynamic>> rows = [];
  List<Map<String, dynamic>> rows1 = [];

  //for the search button
  String? rollDilog;

  //for multiple row
  String? roll;
  String? name;
  String? collage;
  String? domen;
  String? dob;
  String? rollno;

  //for single row
  String? roll0;
  String? name0;
  String? collage0;
  String? domen0;
  String? dob0;
  String? rollno0;

  @override
  void initState() {
    super.initState();
    fetchAllRows();
  }

  //database code/methords
  Future<void> deleteSpacific(String id) async {
    try {
      await dbhelper.deleteSpacific(id);
      setState(() {
        fetchAllRows();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record deleted successfully!')),
      );
    } catch (e) {
      print("Error deleting record: $e");
    }
  }
  Future<void> fetchAllRows() async {
    try {
      rows = await dbhelper.queryall();
      setState(() {});
      print("Fetched rows: $rows");
    } catch (e) {
      print("Error fetching rows: $e");
    }
  }
  Future<void> fetchRow(String roll) async {
    try {
      rows1 = await dbhelper.querySpacific(roll);
      setState(() {});
      print("Fetched rows: $rows1");
    } catch (e) {
      print("Error fetching rows: $e");
    }
  }
  Future<void> update(String roll, String name, String Collage, String Domen, String Dob)async{
    var obj = insert_data(
      name: name,
      colage: Collage,
      roll: roll,
      domen: Domen,
      dob: Dob,
    );
    await dbhelper.updateSpacific(roll, obj);
    setState(() {
      fetchAllRows();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Record Update successfully!')),
    );
  }

  //Dialog code/methords
  void _showWarning(String id) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Warning',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Do you want to delete the data?',
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
                deleteSpacific(id);
                Navigator.of(dialogContext).pop();
              },
              child: Text('Yes', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }
  void _idDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Roll Number To see The Id Card'),
          content: TextFormField(
            controller: rollController1,
            decoration: InputDecoration(
              hintText: 'Enter Roll Number',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without action
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                rollDilog = rollController1.text;
                if (rollDilog != null && rollDilog!.isNotEmpty) {
                  await fetchRow(rollDilog!);
                  Navigator.of(context).pop(); // Close the dialog
                  if (rows1.isNotEmpty ) {
                    Map<String, dynamic> info1 = jsonDecode(rows[0]['info']);
                    name0 = info1['name'];
                    collage0 = info1['colage'];
                    rollno0 = rows1[0]['roll'];
                    domen0 = info1['domen'];
                    dob0 = info1['dob'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IdCardDisplay(
                          collage: collage0,
                          name: name0,
                          roll: rollno0,
                          domen: domen0,
                          dob: dob0,
                        ),
                      ),
                    );
                  } else {
                    // Show a message if no data is found
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('No data found for the provided roll number.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
                else {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Input Field Is Empty'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('View'),
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
        title: Text('List\'s of Id Card'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed:(){
              _idDialog(context);
              rollController1.clear();
            }, icon:Icon(Icons.search,color: Colors.deepPurple,)),
          )
        ],
      ),

      body:rows.isEmpty
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
                Map<String, dynamic> info = jsonDecode(rows[index]['info']);
                name = info['name'];
                collage = info['colage'];
                rollno = rows[index]['roll'];
                domen = info['domen'];
                dob = info['dob'];
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: FutureBuilder<Uint8List?>(
                        future: db_helper.instance.getImage(rows[index]['roll']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Loading indicator
                          } else if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              );
                            }
                          }
                          return Text('no data found');
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NAME:  $name',style: TextStyle(fontFamily: 'LibreBaskerville',fontSize: 12),),
                              Text('ROLL NO:  $rollno',style: TextStyle(fontFamily: 'LibreBaskerville',fontSize: 12),),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              iconSize: 16.0, // desired size
                              padding: EdgeInsets.only(top: 3),
                              constraints: const BoxConstraints(),
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: (){
                                _showWarning(rows[index]['roll']);
                              },
                            ),
                            IconButton(
                              iconSize: 16.0, // desired size
                              padding: EdgeInsets.only(top: 3),
                              constraints: const BoxConstraints(), // override default min size of 48px
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
                              ),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                              onPressed: (){
                                showDialog(context: context, builder:(BuildContext dialogContext){

                                  TextEditingController updateRollController = TextEditingController(text: rows[index]['roll']);
                                  TextEditingController UpdateCollageController = TextEditingController(text: info['colage']);
                                  TextEditingController UpdateNameController = TextEditingController(text: info['name']);
                                  TextEditingController UpdateDomenController = TextEditingController(text: info['domen']);
                                  TextEditingController UpdateDobController = TextEditingController(text: info['dob']);

                                  return AlertDialog(
                                    title:Text('Update ${name} Details'),
                                    content:SingleChildScrollView(
                                      child: Form(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller:UpdateCollageController,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  hintText: 'Enter your Update Collage Name',
                                                  suffixIcon: Icon(
                                                    Icons.school,
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
                                                controller:UpdateNameController,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  hintText: 'Enter your Update Name',
                                                  suffixIcon: Icon(
                                                    Icons.man,
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
                                                controller:updateRollController,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  hintText: 'Enter your Update Roll Number',
                                                  suffixIcon: Icon(
                                                    Icons.ac_unit,
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
                                                controller:UpdateDomenController,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  hintText: 'Enter your Update Domen',
                                                  suffixIcon: Icon(
                                                    Icons.workspaces_filled,
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
                                                controller:UpdateDobController,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  hintText: 'Enter your Update DOB: DD/MM/YYYY',
                                                  suffixIcon: Icon(
                                                    Icons.date_range,
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
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child:Text('Cancel')),
                                      TextButton(onPressed: (){
                                        update(updateRollController.text, UpdateNameController.text, UpdateCollageController.text, UpdateDomenController.text, UpdateDobController.text);
                                        Navigator.of(context).pop();
                                      }, child: Text('Submit'))
                                    ],
                                  );
                                });
                              },
                            ),
                            IconButton(
                              iconSize: 16.0, // desired size
                              padding: EdgeInsets.only(top: 3),
                              constraints: const BoxConstraints(), // override default min size of 48px
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
                              ),
                              icon:  Icon(
                                Icons.all_inbox,
                                color: Colors.deepPurpleAccent,
                              ),
                              onPressed: () async{
                                await fetchRow(rows[index]['roll']);
                                Map<String, dynamic> info1 = jsonDecode(rows1[0]['info']);
                                name0 = info1['name'];
                                collage0 = info1['colage'];
                                rollno0 = rows1[0]['roll'];
                                domen0 = info1['domen'];
                                dob0 = info1['dob'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IdCardDisplay(
                                      collage: collage0,
                                      name: name0,
                                      roll: rollno0,
                                      domen: domen0,
                                      dob: dob0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
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