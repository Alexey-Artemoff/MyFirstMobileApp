import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.grey),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Артёмов Алексей Андреевич', 
          style: TextStyle(
            color: Colors.white
          )),
          
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Здесь будут ваши виджеты
          Column(
            children: [
              Text('ФИО: Артёмов Алексей Андреевич', 
              style: TextStyle(fontSize: 20, 
              fontWeight: FontWeight.bold
              )),
              
              SizedBox(height: 10),
              
              Text('Год рождения: 2005', 
              style: TextStyle(fontSize: 20, 
              fontStyle: FontStyle.italic
              )),
              
              SizedBox(height: 10),
              
              Text('Группа: ИСТУ–23–2', 
              style: TextStyle(fontSize: 20, 
              fontStyle: FontStyle.italic
              )),
              
              SizedBox(height: 10),
              
              Text('ID: ИСТУ-2302', 
              style: TextStyle(fontSize: 20, 
              fontWeight: 
              FontWeight.bold,
              foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 0.5
              ..color = Colors.blue[700]!,
              )),
            ],
          ),
        ],
      ),
    );
  }
  }