import 'package:flutter/material.dart';
import 'package:expenses/components/transaction_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Card(
              color: Colors.blue,
              child: Text('Gráfico'),
              elevation: 5,
            ),
            TransactionUser(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
