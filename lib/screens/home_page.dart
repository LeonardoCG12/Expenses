import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/utils/db.dart';

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
  List<Transactions> _transactions = [];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    DB.instance.database.whenComplete(() {
      _onRefresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    DB.instance.close();
  }

  Future<void> _onRefresh() async {
    _transactions = await DB.instance.getList();
    setState(() {});
  }

  Future<void> _removeTransaction(double id) async {
    await DB.instance.removeList(id);
    _onRefresh();
  }

  Future<void> _addTransaction(String title, double value, int date) async {
    final newTransaction = Transactions(
      id: Random().nextDouble(),
      title: title,
      value: value,
      date: date,
    );

    await DB.instance.addList(newTransaction);
    Navigator.of(context).pop();
    _onRefresh();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xFF9E9E9E),
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

  Widget _getIconButton(Function() fn, IconData icon) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list;

    final chartList =
        Platform.isIOS ? CupertinoIcons.chart_bar_alt_fill : Icons.bar_chart;

    final addList = Platform.isIOS ? CupertinoIcons.add : Icons.add;

    final actions = [
      if (isLandScape)
        _getIconButton(
          () => setState(() {
            _showChart = !_showChart;
          }),
          _showChart ? iconList : chartList,
        ),
      _getIconButton(() => _openTransactionFormModal(context), addList),
    ];

    final appBarAndroid = AppBar(
      elevation: 6,
      title: const Text('Despesas Pessoais'),
      actions: actions,
    );

    final appBarIOS = CupertinoNavigationBar(
      middle: const Text('Despesas Pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    );

    final availableHeight = mediaQuery.size.height -
        (Platform.isIOS
            ? appBarIOS.preferredSize.height
            : appBarAndroid.preferredSize.height) -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 0.75 : 0.25),
                child: Chart(
                  recentTransactions: _transactions,
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
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBarIOS,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBarAndroid,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openTransactionFormModal(context),
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}
