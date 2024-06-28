import 'dart:typed_data';
import 'db_helper.dart';
import 'package:flutter/material.dart';

class IdCardDisplay extends StatefulWidget {
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
  _IdCardDisplayState createState() => _IdCardDisplayState();
}

class _IdCardDisplayState extends State<IdCardDisplay> {
  int i = 0;
  List<String> stringList = [
    'id1.jpg', 'id2.jpeg', 'id3.jpg', 'id4.png', 'id5.jpg',
    'id6.png', 'id7.jpg','id8.jpg', 'id9.jpg', 'id10.jpg','id11.jpg',
    'id12.jpeg', 'id13.jpg', 'id14.png', 'id15.jpg', 'id16.jpg', 'id17.jpeg',
    'id18.jpg', 'id19.jpeg', 'id20.jpeg', 'id21.jpeg', 'id22.jpeg', 'id23.jpg',
  ];

  String get currentImagePath => 'assets/image/${stringList[i]}';

  void pathChange() {
    setState(() {
      i = (i + 1) % stringList.length; // Cycle through the images
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ID Card'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: (){

              },
              child: Icon(Icons.download),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(currentImagePath),
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
                        widget.collage ?? 'No Collage',
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
                        border: Border.all(
                          color: Colors.black, // Border color
                          width: 2.0,        // Border width
                        ),
                      ),
                      child: FutureBuilder<Uint8List?>(
                        future: db_helper.instance.getImage(widget.roll!),
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
                          return Text('No data found');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'NAME: ${widget.name ?? 'No Name'}',
                                style: TextStyle(
                                  fontFamily: 'LibreBaskerville',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black, // Adjust text color if necessary
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'ROLL: ${widget.roll ?? 'No Roll'}',
                                style: TextStyle(
                                  fontFamily: 'LibreBaskerville',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black, // Adjust text color if necessary
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'DOMEN: ${widget.domen ?? 'No Domen'}',
                                style: TextStyle(
                                  fontFamily: 'LibreBaskerville',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black, // Adjust text color if necessary
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                'DOB: ${widget.dob ?? 'No DOB'}',
                                style: TextStyle(
                                  fontFamily: 'LibreBaskerville',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black, // Adjust text color if necessary
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 22),
                    child: Row(
                      children: [
                        Container(
                          child:  FutureBuilder<Uint8List?>(
                            future: db_helper.instance.getImageQr(widget.roll!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Loading indicator
                              } else if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return Image.memory(
                                      snapshot.data!,width: 60, height: 60
                                  );
                                }
                              }
                              return Text('No data found');
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text('Scan The QR code\nFor More Details...'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: pathChange,
                child: Text('Update Theme'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
