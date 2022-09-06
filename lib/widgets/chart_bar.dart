import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totAmount;
  final double totperc;

  // ignore: use_key_in_widget_constructors
  const ChartBar(this.label, this.totAmount, this.totperc);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text('\$ ${totAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          SizedBox(
            width: 10,
            height: constraints.maxHeight * 0.7,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                    heightFactor: totperc,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ))
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    }));
  }
}
