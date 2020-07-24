import 'dart:io';
import 'package:expence_app/Widget/chart.dart';
import 'package:expence_app/Widget/new_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Widget/new_transaction.dart';
import './models/transaction.dart';
import './Widget/transaction_list.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.lime,
        fontFamily: 'QuickSans',
        errorColor: Colors.redAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'QuickSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(color: Colors.white),
        ),

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20.0
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final  List <Transaction> _usertransaction =[];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _usertransaction.where((element) {
    return element.date.isAfter(DateTime.now().subtract(
      Duration(days:  7),  //will return date after subtracting 7 from date of today
    ),);
    }).toList();
  }
  void _addNewTransaction(String txTitle,double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount:  txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    ) ;
    setState(() {
      _usertransaction.add(newTx);
    });
  }
  void _deleteTransaction(String id){
    setState(() {
      _usertransaction.removeWhere((tx) =>tx.id == id );
    });
  }
  void _startAddNewtransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_) {
     return GestureDetector(
         onTap: (){},
         behavior: HitTestBehavior.opaque,
         child: NewTransaction(_addNewTransaction));
    },);
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation ==  Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text('Personal Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child:  Icon(CupertinoIcons.add),
            onTap: () => _startAddNewtransaction(context),
          ),
        ],
      ),
    ) :  AppBar(
      centerTitle: true,
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewtransaction(context),
          icon : Icon( Icons.add),
        ),
      ],
    );

    final txListWidget= Container(
        height: (mediaQuery.size.height - appBar.preferredSize.height- mediaQuery.padding.top)*0.7,
        child: TransactionList(_usertransaction, _deleteTransaction));
    final pageBody = SafeArea(child:SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Show Chart', style:  Theme.of(context).textTheme.subtitle1,),
              Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart ,
                  onChanged: (val)
                  {
                    setState(() {
                      _showChart = val;
                    });
                  }),
            ],
          ),
          if(!isLandscape)Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.3,
              child: Chart(_recentTransactions)),
          if(!isLandscape) txListWidget,
          if(isLandscape)_showChart ? Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)*0.7,
              child: Chart(_recentTransactions)) : txListWidget
        ],
      ),
    ),);
    return Platform.isIOS ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar ,)
        : Scaffold(
      appBar: appBar,
      body: pageBody,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(onPressed:() => _startAddNewtransaction(context),
            child:Icon(Icons.add)),
    );

  }
}










