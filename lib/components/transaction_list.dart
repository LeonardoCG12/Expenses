import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/transaction_items.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final void Function(double) onRemove;

  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onRemove,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return TransactionItems(
                isEmpty: true,
                size: constraints.maxHeight * 0.7,
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              final tr = transactions[index];

              return TransactionItems(
                isEmpty: false,
                tr: tr,
                onRemove: onRemove,
              );
            },
          );
  }
}
