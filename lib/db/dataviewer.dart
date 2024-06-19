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
    rows = await dbhelper.queryall();
    setState(() {});
  }

  Future<void> deleteDatabaseFile() async {
    await dbhelper.deleteDatabaseFile();
    rows = []; // Clear rows after deletion
    setState(() {}); // Update UI
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Database deleted successfully!')),
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
            onPressed: deleteDatabaseFile,
          ),
        ],
      ),
      body: rows.isEmpty
          ? Center(
        child: Text('No data available'),
      )
          : ListView.separated(
        itemCount: rows.length,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 25, thickness: 4),
        itemBuilder: (BuildContext context, int index) {
          final row = rows[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('ID: ${row[db_helper.c_id]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Name: ${row[db_helper.c_name]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Email: ${row[db_helper.c_email]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Address: ${row[db_helper.c_address]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Mobile: ${row[db_helper.c_mobile]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Gender: ${row[db_helper.c_gender]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Facebook URL: ${row[db_helper.c_facbook]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Insta URL: ${row[db_helper.c_insta]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    Text('Tuter URL: ${row[db_helper.c_tuiter]}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
