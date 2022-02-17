import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';

class TransactionItems extends StatelessWidget {
  final bool isEmpty;
  final double? size;
  final Transactions? tr;
  final void Function(double)? onRemove;

  const TransactionItems({
    Key? key,
    required this.isEmpty,
    this.size,
    this.tr,
    this.onRemove,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final deleteIconList =
        Platform.isIOS ? CupertinoIcons.delete_solid : Icons.delete;

    final dragIconList = Platform.isIOS
        ? CupertinoIcons.arrow_left_to_line_alt
        : Icons.drag_indicator;

    return isEmpty
        ? Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              children: [
                Text(
                  'Nenhuma Transação Cadastrada',
                  style: TextStyle(
                    color: theme.colorScheme.background,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 22,
                  ),
                  height: size,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : Card(
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: const EdgeInsets.only(
                  right: 30,
                ),
                alignment: Alignment.centerRight,
                color: theme.errorColor,
                child: Icon(
                  deleteIconList,
                  color: theme.colorScheme.background,
                ),
              ),
              onDismissed: (_) {
                onRemove!(tr!.id);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Item [${tr!.title}] excluído'),
                  ),
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        'R\$ ${tr!.value.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: theme.colorScheme.background,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: Text(
                    tr!.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: Text(DateFormat('dd/MM/y')
                      .format(DateTime.fromMillisecondsSinceEpoch(tr!.date))),
                ),
                trailing: MediaQuery.of(context).size.width > 420
                    ? TextButton.icon(
                        onPressed: () => onRemove!(tr!.id),
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir'),
                        style: TextButton.styleFrom(
                          primary: theme.errorColor,
                        ),
                      )
                    : Icon(
                        dragIconList,
                        color: theme.errorColor,
                      ),
              ),
            ),
          );
  }
}
