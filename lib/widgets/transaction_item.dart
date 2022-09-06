import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required transaction,
    required Function deleteTransaction,
  })  : _transaction = transaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final _transaction;
  final Function _deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    final availableColors = [
      Colors.black,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.deepPurple,
      Colors.deepOrange,
      Colors.blue,
    ];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$ ${widget._transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          widget._transaction.description,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget._transaction.date),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.blueGrey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget._deleteTransaction(widget._transaction.id),
        ),
      ),
    );
  }
}
