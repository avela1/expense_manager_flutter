import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTrans;

  // ignore: use_key_in_widget_constructors
  const NewTransaction(this._addNewTrans);
  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // ignore: avoid_init_to_null
  late DateTime? _selectedDate = null;

  void _handlePress() {
    final String title = _titleController.text;
    final double amount = double.parse(_amountController.text);

    if (_selectedDate == null || title.isEmpty || amount <= 0) return;
    widget._addNewTrans(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_selectedDate);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: _titleController,
                style: const TextStyle(fontSize: 12),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _handlePress(),
                style: const TextStyle(fontSize: 12),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Date is not selected yet      '
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ), 
                  ),
                  TextButton(
                    onPressed: () => _displayDatePicker(),
                    child: const Text('choose date'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: ElevatedButton(
                  onPressed: () => _handlePress(),
                  child: const Text('Add Transactions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
