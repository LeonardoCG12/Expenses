import 'dart:math';
import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transaction_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where(
      (tr) {
        return tr.date.isAfter(DateTime.now().subtract(
          const Duration(
            days: 7,
          ),
        ));
      },
    ).toList();
  }

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TransactionForm(
              onSubmit: _addTransaction,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      elevation: 6,
      title: const Text('Despesas Pessoais'),
      actions: [
        if (isLandScape)
          IconButton(
            onPressed: () => setState(() {
              _showChart = !_showChart;
            }),
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 0.75 : 0.25),
                child: Chart(
                  recentTransactions: _recentTransactions,
                ),
              ),
            if (!_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 1 : 0.75),
                child: TransactionList(
                  transactions: _transactions,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
