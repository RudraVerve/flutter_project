import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'db_helper.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class IdCardDisplay extends StatefulWidget {
  final String? Company;
  final String? name;
  final String? id;
  final String? Technology;
  final String? dob;

  IdCardDisplay({
    this.Company,
    this.name,
    this.id,
    this.Technology,
    this.dob,
  });

  @override
  _IdCardDisplayState createState() => _IdCardDisplayState();
}

class _IdCardDisplayState extends State<IdCardDisplay> {
  final GlobalKey _globalKey = GlobalKey();
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

  Future<void> _captureAndSave({bool isPdf = false}) async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        print('Storage permission not granted');
        return;
      }

      // Capture the image
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List(); // list of unsignd 8bit data..

      // Save the image to the gallery or as PDF
      if (!isPdf) {
        // Save as PNG
        final result = await ImageGallerySaver.saveImage(pngBytes, name: "container_image");
        print('Image saved to gallery: $result');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PNG saved to gallery')),
        );
      } else {
        // Save as PDF
        final pdf = pw.Document();                //create new pdf file
        pdf.addPage(                              //add a page to the pdf file
          pw.Page(                                //add the content of the pdf file
            build: (pw.Context context) {
              return pw.Center(                   //center the content of the pdf file
                child: pw.Image(                  //give the image to conver it to pdf
                  pw.MemoryImage(pngBytes),
                ),
              );
            },
          ),
        );

        // Get the download directory path
        Directory? downloadDirectory;
        if (Platform.isAndroid) {
          downloadDirectory = await Directory("/storage/emulated/0/Download"); //store in download
          // downloadDirectory = await getDownloadsDirectory();          //store in app folder
        } else {
          downloadDirectory = await getApplicationDocumentsDirectory();
        }

        // Save the PDF document in the download path
        final file = File('${downloadDirectory.path}/container1.pdf');
        await file.writeAsBytes(await pdf.save());

        print('PDF saved to local storage: ${file.path}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF saved to local storage')),
        );
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee ID Card'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Container(
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
                          widget.Company ?? 'No Company',
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
                          future: db_helper.instance.getImage(widget.id!),
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
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  'ID: ${widget.id ?? 'No Id'}',
                                  style: TextStyle(
                                    fontFamily: 'LibreBaskerville',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  'Technology: ${widget.Technology ?? 'No Technology'}',
                                  style: TextStyle(
                                    fontFamily: 'LibreBaskerville',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
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
                                    color: Colors.black,
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
                              future: db_helper.instance.getImageQr(widget.id!),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: pathChange,
                    child: Text('Update Theme'),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download_for_offline, color: Colors.green,size: 30,
                      ),
                      onPressed: (){
                        _captureAndSave();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Download successful')),
                        );
                      },
                    ),
                    Text('.png',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17))
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download_for_offline, color: Colors.green,size: 30
                      ),
                      onPressed: (){
                        _captureAndSave(isPdf: true); // Save as PDF
                      },
                    ),
                    Text('.pdf',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
