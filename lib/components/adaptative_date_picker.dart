import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final int? selectedDate;
  final Function(DateTime) onDateChange;

  const AdaptativeDatePicker({
    Key? key,
    required this.selectedDate,
    required this.onDateChange,
  }) : super(
          key: key,
        );

  void _showDatePicker(BuildContext context) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime(DateTime.now().year + 2),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (BuildContext context, Widget? child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: const Color(0xFF13400C),
                ),
                dialogBackgroundColor: const Color(0xFFCFCFCF),
              ),
              child: child!,
            )).then((pickedDate) {
      if (pickedDate != null) {
        onDateChange(pickedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.26,
            child: CupertinoDatePicker(
              backgroundColor: const Color(0xFFCFCFCF),
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(DateTime.now().year - 2),
              maximumDate: DateTime(DateTime.now().year + 2),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data: ' +
                            DateFormat('dd/MM/y').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    selectedDate!)),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: const Text(
                    'Selecionar Data',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
