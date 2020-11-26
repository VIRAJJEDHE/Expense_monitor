import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:expense_monitor/common/calendar.dart';
import 'package:expense_monitor/redux/selectors.dart';
import 'package:expense_monitor/redux/state.dart';
import 'package:expense_monitor/repository/firestore.dart';
import 'package:expense_monitor/repository/firestore_calculator.dart';
import 'package:expense_monitor/theme/palette.dart' as Palette;
import 'package:expense_monitor/ui/common/progress_indicator.dart';
import 'package:expense_monitor/ui/common/text.dart';

class BalanceCard extends StatelessWidget {
  final DateTime from;
  final DateTime to;

  BalanceCard({@required this.from, @required this.to});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromState,
      builder: (context, vm) {
        return Card(
          color: Colors.black,
          child: StreamBuilder<QuerySnapshot>(
            stream: vm.database.snapshotBetween(from, to),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return PaddedCircularProgressIndicator();
              }

              double income = totalIncome(snapshot.data.documents);
              double expenses = totalExpense(snapshot.data.documents);
              double balance = income - expenses;

              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: CenteredText(
                          text: currentMonth(),
                          fontWeight: FontWeight.bold,
                        )),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        summary(context, "Income", income),
                        summary(context, "Expenses", expenses),
                        summary(context, "Balance", balance),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final FirestoreDatabase database;

  _ViewModel({@required this.database});

  static _ViewModel fromState(Store<AppState> store) {
    return _ViewModel(database: getRepository(store.state));
  }
}

Widget summary(BuildContext context, String text, double amount) => Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 14.0,
                  color: Colors.lightGreenAccent,
                ),
          ),
          Text(
            amount.toStringAsFixed(2),
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
