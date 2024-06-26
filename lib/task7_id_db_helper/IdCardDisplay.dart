import 'package:flutter/material.dart';

class IdCardDisplay extends StatelessWidget {
  final String? collage;
  final String? name;
  final String? roll;
  final String? domen;
  final String? dob;

  IdCardDisplay({
    this.collage,
    this.name,
    this.roll,
    this.domen,
    this.dob,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ID Card'),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/id1.jpg'),
              fit: BoxFit.cover,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black, // Border color
              width: 3.0,        // Border width
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    '$collage',
                    textAlign: TextAlign.center, // Center aligns the text
                    style: TextStyle(
                      fontFamily: 'LibreBaskerville',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black, // Adjust text color if necessary
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 150,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 2.0,        // Border width
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                        'Name: ${name ?? 'N/A'}\n'
                        'Roll: ${roll ?? 'N/A'}\n'
                        'Domen: ${domen ?? 'N/A'}\n'
                        'DOB: ${dob ?? 'N/A'}',
                    textAlign: TextAlign.center, // Center aligns the text
                    style: TextStyle(
                      fontFamily: 'LibreBaskerville',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black, // Adjust text color if necessary
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
