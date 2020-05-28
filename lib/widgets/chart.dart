import 'package:expensesapp/models/transaction.dart';
import 'package:expensesapp/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  //this list return the specific day of the week usuing the list generate to calculate by the index I get, using the Date.now geting the date and sub the index I send it.
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double value = 0.0;

      for(var i = 0; i < recentTransactions.length; i++){
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if(sameDay && sameMonth && sameYear){
          value += recentTransactions[i].value;
        }

      }

      //test
      print(value);

      return {'day': DateFormat.E().format(weekDay), 'value': value};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr){
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((f){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: f['day'],
                  value: f['value'],
                  percentage:  _weekTotalValue == 0 ? 0 : (f['value'] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
