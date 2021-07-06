import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDo;

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              centerTitle: true,
              title: Text('Налаштування'),
            ),
            body: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Text(
                    'Login: Перець Павло',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Вийти з акаунта',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _menuOpen,
            icon: Icon(Icons.menu_outlined),
          ),
        ],
        backgroundColor: Colors.deepOrange,
        title: Text('Список необхідних завдань'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        items: [
          BottomNavigationBarItem(
            title: Text('Виконано'),
            icon: Icon(Icons.done),
          ),
          BottomNavigationBarItem(
            title: Text('Налаштування'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Додати нове завдання'),
                content: TextField(
                  onChanged: (String value) {
                    _userToDo = value;
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('items')
                            .add({'item': _userToDo});
                        Navigator.of(context).pop();
                      },
                      child: Text('Додати завдання'),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text(
                'Немає записів',
                style: TextStyle(fontSize: 25),
              ),
            );
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(snapshot.data!.docs[index].id),
                child: Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data!.docs[index].get('item'),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_sweep),
                      color: Colors.deepOrange,
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('items')
                            .doc(snapshot.data!.docs[index].id)
                            .delete();
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(snapshot.data!.docs[index].id)
                      .delete();
                },
              );
            },
          );
        },
      ),
    );
  }
}
