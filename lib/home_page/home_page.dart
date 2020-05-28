import 'dart:math';

import 'package:expensesapp/models/transaction.dart';
import 'package:expensesapp/widgets/chart.dart';
import 'package:expensesapp/widgets/transaction_list.dart';
import 'package:expensesapp/widgets/transation_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transaction = [];

  List<Transaction> get _recentTransactions {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr){
        return tr.id == id;
      });
    });
  }

  _openModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Expenses App',
          style: TextStyle(color: Colors.pink),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_box,
              color: Colors.pink,
            ),
            onPressed: () => _openModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(
              _recentTransactions,
            ),
            TransactionList(_transaction, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add_box,
          color: Colors.pink,
        ),
        onPressed: () => _openModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
