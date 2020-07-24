import 'package:expence_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
 final List <Transaction> transactions; //TODO transactions list
 final Function deleteTx;
 TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? LayoutBuilder(builder: (context , constraints){
    return Column(
    children: <Widget>[
    Text('No transaction!',
    style: Theme.of(context).textTheme.headline6,),
    SizedBox(
    height: 20,
    ),
    Container(
    height: constraints.maxHeight*0.6,
    child: Image.asset('image/waiting.png',
    fit: BoxFit.cover,
    ),
    ),
    ],
    );
    })
        : ListView.builder(
      itemBuilder: (context,index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(child: Text('Rs ${transactions[index].amount}')),
              ),
            ),
            trailing: MediaQuery.of(context).size.width> 420 ?
            FlatButton.icon(
                onPressed: () => deleteTx(transactions[index].id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
            textColor: Colors.red,)
                :  IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transactions[index].id)),
            title: Text(
              transactions[index].title,
              style: Theme.of(context).textTheme.headline6,),
            subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)
            ),

          ),
        );
      },
      itemCount: transactions.length,
      );
  }
}
