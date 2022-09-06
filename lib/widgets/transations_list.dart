import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List _transactions;
  final Function _deleteTransaction;

  // ignore: use_key_in_widget_constructors
  const TransactionsList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      '\$ ${_transactions[index].amount.toStringAsFixed(2)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              title: Text(
                _transactions[index].description,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(_transactions[index].date),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.blueGrey),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => _deleteTransaction(_transactions[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}