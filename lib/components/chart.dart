import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(
          key: key,
        );

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(
            days: index,
          ),
        );

        double totalSum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          bool sameDay =
              DateTime.fromMillisecondsSinceEpoch(recentTransactions[i].date)
                      .day ==
                  weekDay.day;
          bool sameMonth =
              DateTime.fromMillisecondsSinceEpoch(recentTransactions[i].date)
                      .month ==
                  weekDay.month;
          bool sameYear =
              DateTime.fromMillisecondsSinceEpoch(recentTransactions[i].date)
                      .year ==
                  weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += recentTransactions[i].value;
          }
        }

        return {
          'day': DateFormat.E('pt_BR').format(weekDay).toUpperCase(),
          'value': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + double.parse(tr['value'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return Card(
      color: const Color(0xFFCFCFCF),
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Expanded(
              child: ChartBar(
                label: tr['day'].toString(),
                value: tr['value'] as double,
                percentage: _weekTotalValue > 0.0
                    ? (tr['value'] as double) / _weekTotalValue
                    : 0.0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
