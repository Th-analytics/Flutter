import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount,this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint){
      return Column(
      children: <Widget>[
        Container(
            height: constraint.maxHeight*0.15,
            child: FittedBox(child: Text( ' Rs.${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: constraint.maxHeight*0.05,
        ),
        Container(
          height: constraint.maxHeight*0.6,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromARGB(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraint.maxHeight*0.05,
        ),
        Container(
            height:constraint.maxHeight*0.15,
            child: FittedBox(child: Text(label))),
      ],
    );},);
  }
}
