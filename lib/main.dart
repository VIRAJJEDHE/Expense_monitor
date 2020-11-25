import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:expense_monitor/redux/actions.dart';
import 'package:expense_monitor/redux/middlewares/auth.dart';
import 'package:expense_monitor/redux/middlewares/categories.dart';
import 'package:expense_monitor/redux/middlewares/entries.dart';
import 'package:expense_monitor/redux/reducers.dart';
import 'package:expense_monitor/redux/state.dart';
import 'package:expense_monitor/theme/theme.dart';
import 'package:expense_monitor/ui/categories/category_list.dart';
import 'package:expense_monitor/ui/common/buttons.dart';
import 'package:expense_monitor/ui/entries/add_entry_page.dart';
import 'package:expense_monitor/ui/entries/edit_entry_page.dart';
import 'package:expense_monitor/ui/forms/registration.dart';
import 'package:expense_monitor/ui/forms/signin.dart';
import 'package:expense_monitor/ui/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final navigatorKey = GlobalKey<NavigatorState>();
  final Store store = Store<AppState>(
    reduce,
    distinct: true,
    initialState: AppState(areCategoriesLoading: true),
    middleware: [
      CategoryMiddleware(),
      EntryMiddleware(),
      AuthMiddleware(navigatorKey),
    ],
  );
  store.dispatch(RetrieveUser());

  runApp(expense_monitor(navigatorKey, store));
}

// ignore: camel_case_types
class expense_monitor extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Store<AppState> store;

  expense_monitor(this.navigatorKey, this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Expense Monitor',
        theme: appTheme,
        navigatorKey: navigatorKey,
        routes: {
          InitialPage.route: (context) => InitialPage(),
          RegistrationForm.route: (context) => RegistrationForm(),
          CategoryList.route: (context) => CategoryList(),
          HomeScreen.route: (context) => HomeScreen(),
          AddExpensePage.route: (context) => AddExpensePage(),
          EditExpensePage.route: (context) => EditExpensePage(),
        },
        initialRoute: InitialPage.route,
      ),
    );
  }
}

class InitialPage extends StatelessWidget {
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignInForm(),
              RoundedButton(
                text: 'Register',
                buttonColor: Colors.blue,
                onPressed: () => Navigator.pushNamed(
                  context,
                  RegistrationForm.route,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
