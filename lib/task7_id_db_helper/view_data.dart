// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'IdCardDisplay.dart';
// import 'db_helper.dart';
//
// class viewData extends StatefulWidget {
//   @override
//   _DataViewerState createState() => _DataViewerState();
// }
//
// class _DataViewerState extends State<viewData> {
//   TextEditingController idController = TextEditingController();
//   final dbhelper = db_helper.instance;
//   List<Map<String, dynamic>> rows = [];
//   String? roll;
//   String? name;
//   String? collage;
//   String? domen;
//   String? dob;
//   String? rollno;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<void> fetchRows(int roll) async {
//     try {
//       rows = await dbhelper.queryall(roll);
//       setState(() {});
//       print("Fetched rows: $rows");
//     } catch (e) {
//       print("Error fetching rows: $e");
//     }
//   }
//
//   void _idDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter Roll Number To see The Id Card'),
//           content: TextFormField(
//             controller: idController,
//             decoration: InputDecoration(
//               hintText: 'Enter Roll Number',
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog without action
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 roll = idController.text;
//                 var myInt = int.tryParse(roll ?? '');
//                 if (myInt != null) {
//                   await fetchRows(myInt); // Fetch the data based on the roll number
//                   Navigator.of(context).pop(); // Close the dialog
//                   if (rows.isNotEmpty) {
//                     // Assuming there's only one row fetched based on roll number
//                     Map<String, dynamic> info = jsonDecode(rows[0]['info']);
//                     name = info['name'];
//                     collage = info['colage']; // Note the typo 'colage' instead of 'college'
//                     rollno = info['roll'];
//                     domen = info['domen'];
//                     dob = info['dob'];
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => IdCardDisplay(
//                           collage: collage,
//                           name: name,
//                           roll: rollno,
//                           domen: domen,
//                           dob: dob,
//                         ),
//                       ),
//                     );
//                   } else {
//                     // Show a message if no data is found
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text('Error'),
//                         content: Text('No data found for the provided roll number.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 }
//               },
//               child: Text('View'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.pinkAccent.withOpacity(0.5),
//               Colors.deepPurpleAccent.withOpacity(0.8),
//               Colors.grey.withOpacity(0.8),
//               Colors.black.withOpacity(0.8),
//             ],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: ElevatedButton(
//               onPressed: () {
//                 _idDialog(context);
//               },
//               child: Text('View Id Card'),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(150, 40), // Set the width and height of the button
//                 shadowColor: Colors.black,  // Set the shadow color
//                 elevation: 12,              // Increase the elevation for a more pronounced shadow
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20), // Set the border radius
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }