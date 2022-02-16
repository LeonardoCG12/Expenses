import 'package:flutter/material.dart';
import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_text_field.dart';
import 'package:expenses/components/adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, int) onSubmit;

  const TransactionForm({
    Key? key,
    required this.onSubmit,
  }) : super(
          key: key,
        );

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  int? _selectedDate;

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isNotEmpty && !value.isNegative && _selectedDate != null) {
      widget.onSubmit(title, value, _selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFCFCFCF),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AdaptativeTextField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              labelText: 'Título',
              submitForm: (_) => _submitForm(),
            ),
            AdaptativeTextField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              labelText: 'Valor (R\$)',
              submitForm: (_) => _submitForm(),
            ),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChange: (newDate) => setState(
                () {
                  _selectedDate = DateTime(
                    newDate.year,
                    newDate.month,
                    newDate.day,
                  ).millisecondsSinceEpoch;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
