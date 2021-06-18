import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addtx;

  NewTransactions(this.addtx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enterTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enterTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addtx(
      enterTitle,
      enteredAmount,
      _selectedDate,
    ); //widget gives access to properties of class newtransactionstate
    Navigator.of(context).pop(); // closes new transaction when onsubmit is run
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'no date chosen!'
                            : 'picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        'choose date',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _presentDatePicker();
                      },
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.purple,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
