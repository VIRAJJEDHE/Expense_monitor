import 'package:flutter/material.dart';
import 'package:expense_monitor/ui/statistics/month_summary.dart';
import 'package:expense_monitor/ui/statistics/year_summary.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MonthExpenses(),
        YearExpenses(to: DateTime.now()),
      ],
    );
  }
}
