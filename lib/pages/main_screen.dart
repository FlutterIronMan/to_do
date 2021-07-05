import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Вітаємо в програмі !'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Додаток для управління замітками',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/todo');
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Перехід на екран із завданнями',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
