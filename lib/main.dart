import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class SecondScreen extends StatelessWidget {
  String text;
  SecondScreen({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(("Ваш результат: $text"), style: TextStyle(fontSize: 20.0)),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _agreement = false;
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Text(
              "Введите число A:",
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(controller: _aController, validator: (value) {
              if (value!.isEmpty) return "Введите число A!";
              return null;
            }, keyboardType: TextInputType.number,),
            const SizedBox(height: 20.0),
            const Text(
              "Введите число B:",
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(controller: _bController, validator: (value) {
              if (value!.isEmpty) return "Введите число B!";
              return null;
            }, keyboardType: TextInputType.number,),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              value: _agreement,
              title: Text("Я ознакомлен и согласен с документом 'Согласие на обработку персональных данных'."),
              onChanged: (bool? value) => setState(() => _agreement = value!),
              ),
            const SizedBox(height: 20.0),
            ElevatedButton(onPressed: () {
              if (!_formKey.currentState!.validate()){
                return;
              }
              if (!_agreement) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Необходимо согласиться на обработку персональных данных",
                  ),
                ),
              );
              return;
            }

            int a = int.parse(_aController.text);
            int b = int.parse(_bController.text);

            int result = (a + b) * (a + b);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(text: result.toString())
                  )
              );
          },
          child: const Text("Рассчитать квадрат суммы"),
          )
        ],
      )
      )
    );
  }
}