import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import '/widgets/transations_list.dart';
import 'models/transactions.dart';
import 'widgets/new_transation.dart';
import '/widgets/chart.dart';

void main() {
  /** This is to setup the portrait mode ... */

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(fontFamily: 'RubikWetPaint'),
              titleMedium: const TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              titleSmall: const TextStyle(fontFamily: 'Lobster', fontSize: 10),
            ),
        errorColor: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: prefer_final_fields
  final List<Transactions> _transactions = [];
  bool _showChart = false;

  List<Transactions> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(txtTitle, txtAmount, choosenDate) {
    final newTrans = Transactions(
      id: DateTime.now().toString(),
      description: txtTitle,
      amount: txtAmount,
      date: choosenDate,
    );
    setState(() {
      _transactions.add(newTrans);
    });
  }

  void _popUpAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((idtxt) => idtxt.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: const Text('Expense App Manager'),
    );

    final displayTranList = SizedBox(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionsList(_transactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: _transactions.isEmpty
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    1,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Show Chart'),
                        Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          },
                        ),
                      ],
                    ),
                  if (isLandscape)
                    _showChart
                        ? SizedBox(
                            height: (MediaQuery.of(context).size.height -
                                    appbar.preferredSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.7,
                            child: Chart(_recentTransactions),
                          )
                        : displayTranList,
                  if (!isLandscape)
                    SizedBox(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.3,
                      child: Chart(_recentTransactions),
                    ),
                  if (!isLandscape) displayTranList,
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _popUpAddNewTransaction(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
