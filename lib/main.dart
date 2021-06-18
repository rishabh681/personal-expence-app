import 'package:ExpenseApp/widgets/chart.dart';
import 'package:ExpenseApp/widgets/new_transactions.dart';
import 'package:flutter/material.dart';

import 'models/transactions.dart';
import 'widgets/transaction_list.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  //DeviceOrientation.portraitUp,
  // DeviceOrientation.portraitDown,
  //]); //restricting orientation to portrait
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "personal Expense",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool showChart = false;
  List<Transaction> get _recntTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNeWtx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(_addNewTransactions),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Colors.purple,
      title: Text(
        "Personal Expenses",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNeWtx(context);
            })
      ],
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("show chart"),
                  Switch(
                      value: showChart,
                      onChanged: (val) {
                        setState(() {
                          showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              (Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      .3,
                  child: Chart(_recntTransactions))),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              showChart
                  ? (Container(
                      height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top),
                      child: Chart(_recntTransactions)))
                  : txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNeWtx(context);
        },
      ),
    );
  }
}
