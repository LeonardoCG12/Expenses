import 'package:flutter/material.dart';
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

    if (isEmpty) {
      return Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            const Text(
              'Nenhuma Transação Cadastrada',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
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
      );
    } else {
      return Card(
        color: const Color(0xFFCFCFCF),
        elevation: 6,
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 8,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  'R\$ ${tr!.value.toStringAsFixed(2)}',
                  style: const TextStyle(color: Color(0xFFFFFFFF)),
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
              : IconButton(
                  onPressed: () => onRemove!(tr!.id),
                  icon: const Icon(Icons.delete),
                  color: theme.errorColor,
                ),
        ),
      );
    }
  }
}
