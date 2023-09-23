import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text("Index 0: Home", style: optionStyle),
    Text("Index 1: Business", style: optionStyle),  
    Text("Index 2: School", style: optionStyle),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Components"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple, ),
              child: Text("Hola Maxito")),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text("Home"),
              //trailing: Icon(Icons.home),
              selected: _selectedIndex==0,
              onTap: (){
                _onItemTapped(0);
                Navigator.pop(context); //hace que despues de presionar el icono se cierre el menu
              },
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: const Text("Work"),
              //trailing: Icon(Icons.home),
              selected: _selectedIndex==1,
              onTap: (){
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: const Text("School"),
              //trailing: Icon(Icons.home),
              selected: _selectedIndex==2,
              onTap: (){
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        )
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
