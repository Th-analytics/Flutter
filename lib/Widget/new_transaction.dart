import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() { //TODO Data Submission
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _percentDatePicker() {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 15,
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  height: 70.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No date Chosen'
                              : 'Picked Date:${DateFormat.yMMMd().format(_selectedDate)}',
                        ),
                      ),
                      FlatButton(
                          onPressed: _percentDatePicker,
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'Chose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: _submitData,
                  color: Theme.of(context).primaryColorDark,
                  child: Text('Add Amount'),
                  textColor: Theme.of(context).textTheme.button.color,
                )
              ]),
        ),
      ),
    );
  }
}
