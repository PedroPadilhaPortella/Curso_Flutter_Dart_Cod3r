import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:io';

import 'models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/chart.dart';
import 'components/transaction_list.dart';

main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.amber,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta Antiga',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't3',
      title: 'Whey Protein Growth',
      value: 111345.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't4',
      title: 'Almoço Santander',
      value: 17.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Almoço Santander',
      value: 17.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Almoço Santander',
      value: 17.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Almoço Santander',
      value: 17.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Almoço Santander',
      value: 17.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Almoço Santander',
      value: 17.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Almoço Santander',
      value: 17.30,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  Widget _getIconButton(IconData icon, VoidCallback fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.news : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.graph_square : Icons.show_chart;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(_showChart ? iconList : iconChart, () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionFormModal(context))
    ];

    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Despesas Pessoais',
              style: TextStyle(fontSize: 20 * mediaQuery.textScaleFactor),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(fontSize: 20 * mediaQuery.textScaleFactor),
            ),
            actions: actions,
          )) as PreferredSizeWidget;

    final avaliableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_showChart || !isLandscape)
            Container(
              child: Chart(_recentTransactions),
              height: avaliableHeight * (isLandscape ? 0.8 : 0.25),
            ),
          if (!_showChart || !isLandscape)
            Container(
              child: TransactionList(_transactions, _removeTransaction),
              height: avaliableHeight * (isLandscape ? 1 : 0.75),
            ),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: (appBar) as ObstructingPreferredSizeWidget,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
