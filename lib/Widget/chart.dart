import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

 List<Map<String, Object>> get groupedtransactionvalues{
   // List for generating & days of week
   return List.generate(7, (index) { //Index starts with 0
     final weekDay = DateTime.now().subtract(Duration(days: index));
     var totalSum = 0.0;
     for(var i=0; i < recentTransaction.length; i++)
       {
         if(recentTransaction[i].date.day == weekDay.day
             && recentTransaction[i].date.month == weekDay.month
             && recentTransaction[i].date.month == weekDay.month)
           {
             totalSum += recentTransaction[i].amount;
           }
       }
     print(DateFormat.E().format(weekDay));
     print(totalSum);
     return {
       'day': DateFormat.E().format(weekDay).substring(0,1), //For getting week day
       'amount': totalSum
     };
   }).reversed.toList();
 }

 double get totalSpending{

   return groupedtransactionvalues.fold(0.0, (sum, item) {
     return sum + item['amount'];
   });
 }
  @override
  Widget build(BuildContext context) {
   print(groupedtransactionvalues);
   return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedtransactionvalues.map((data){
            return Flexible(
              fit:  FlexFit.tight,
              child: ChartBar(data['day'], data['amount'],
                totalSpending == 0.0 ? 0.0 :
              (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
