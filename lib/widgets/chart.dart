import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transactions.dart';

// ignore: use_key_in_widget_constructors
class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  // ignore: use_key_in_widget_constructors
  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransVal {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalAmount {
    return groupedTransVal.fold(0.0, (previousValue, element) {
      double curr = element['amount'] as double;
      return previousValue + curr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransVal.map<Widget>((data) {
          return ChartBar(
            data['day'] as String,
            data['amount'] as double,
            totalAmount == 0.0 ? 0.0 : (data['amount'] as double) / totalAmount,
          );
        }).toList(),
      ),
    );
  }
}
