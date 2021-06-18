import 'package:ExpenseApp/models/transactions.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? Column(
            children: <Widget>[
              Text("NO TRANSACTIONS ADDED HERE"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                child: Card(
                  elevation: 7,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 35,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                            child:
                                Text("Rs:${_userTransactions[index].amount}")),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_userTransactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        _deleteTransaction(_userTransactions[index].id);
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
