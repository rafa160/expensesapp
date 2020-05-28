import 'package:expensesapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transations;
  final void Function(String) onRemove;

  TransactionList(this.transations, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transations.isEmpty
          ? Center(
              child: Text(
                'Nothing here yet...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: transations.length,
              itemBuilder: (context, index) {
                final tr = transations[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('\$${tr.value}', style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    trailing: IconButton(icon: Icon(Icons.delete), color: Colors.red,
                      onPressed: () => onRemove(tr.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
