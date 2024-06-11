import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Free flutter course"),
        ),
        body:Container(
          // height : height,
          // width : width,
          // padding: EdgeInsets.all(20.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  // width: 500,
                  // height : height,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                          Container(

                              decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 1.0, // Border width
                              ),
                              ),
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: Text("Well come to flutter design", style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),))
                          ),
                          Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              child: Text("Flutter is a cross-platform UI toolkit that is designed to allow code reuse across operating systems such as iOS and Android, while also allowing applications to interface directly with underlying platform services.", style: TextStyle(fontSize: 20),)
                          ),
                          Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 30.0,
                                        ),

                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 30.0,
                                        ),

                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 30.0,
                                        ),

                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 30.0,
                                        ),

                                        Icon(
                                          Icons.star,
                                          color: Colors.black,
                                          size: 30.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("189+ Rattings",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                          Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        'assets/image/toy3.png',
                                        width: 80.0, // Adjust size as needed
                                        height: 80.0,
                                      ),

                                      Text("course 1"),

                                      ElevatedButton(
                                        child: Text("Click to start"),
                                        onPressed: (){

                                        },
                                      )

                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/image/toy2.png',
                                        width: 80.0, // Adjust size as needed
                                        height: 80.0,
                                      ),

                                      Text("course 2"),

                                      ElevatedButton(
                                        child: Text("Click to start"),
                                        onPressed: (){

                                        },
                                      )

                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/image/toy1.png',
                                        width: 80.0, // Adjust size as needed
                                        height: 80.0,
                                      ),

                                      Text("course 3"),

                                      ElevatedButton(
                                        child: Text("Click to start"),
                                        onPressed: (){

                                        },
                                      )

                                    ],
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                ),
              ),

              Expanded(
                child: Container(
                  child: Image.asset('assets/image/img1.png',
                    fit: BoxFit.cover),
                ),
              )
            ] ,
          ),
        )
    );
  }
}
