import 'package:flutter/material.dart';
import 'package:expense_monitor/ui/drawer.dart';
import 'package:expense_monitor/ui/entries/add_entry_page.dart';
import 'package:expense_monitor/ui/entries/entries_page.dart';
import 'package:expense_monitor/ui/statistics/statistics_page.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      extendBody: true,
      key: _scaffoldKey,
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text('Expense Monitor'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          EntriesPage(),
          StatisticsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add an expense',
        isExtended: true,
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, AddExpensePage.route),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Material(
          //color: Theme.of(context).scaffoldBackgroundColor,
          child: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.receipt)),
              Tab(icon: Icon(Icons.insert_chart)),
            ],
            controller: _tabController,
            labelColor: Colors.indigo,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
