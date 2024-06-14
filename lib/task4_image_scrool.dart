import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biodata app',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Drawer Header
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              // Dashboard Item
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () {
                  // Handle the dashboard action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              // Profile Item
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  // Handle the profile action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              // Settings Item
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Handle the settings action
                  Navigator.pop(context); // Close the drawer
                },
              ),
              // Logout Item
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Handle the logout action
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        ),
      appBar: AppBar(
        title: Text('My Dashbord'),
      ),
      body:ListView(
        children: [
          SizedBox(
          height: 350,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0,left: 10.0,right: 8.0),
                      child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/image/img2.jpeg', fit: BoxFit.cover,)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
      )
    );
  }
}
