import 'dart:convert';
import 'package:flutter/material.dart';
import 'IdCardDisplay.dart';
import 'db_helper.dart';

class IdList extends StatefulWidget {
  const IdList({super.key});
  @override
  State<IdList> createState() => _IdListState();
}

class _IdListState extends State<IdList> {

  final dbhelper = db_helper.instance;
  List<Map<String, dynamic>> rows = [];
  List<Map<String, dynamic>> rows1 = [];

  String? roll;
  String? name;
  String? collage;
  String? domen;
  String? dob;
  String? rollno;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List\'s of Id Card'),
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
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 1.0,        // Border width
                        ),
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
                              onPressed: (){},
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