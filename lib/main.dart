import 'package:flutter/material.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/ui/account.dart';
import 'package:money_app/ui/home.dart';
import 'package:money_app/ui/report.dart';
import 'package:money_app/ui/splash_screen.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel.instance,
        child: const MainPage(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        if (value.listRecord == null) {
          return SplashScreen();
        }
        return _buildMainLayout(listRecord: value.listRecord);
      },
    );
  }

  Widget _buildMainLayout({@required List<Record> listRecord}) {
    final amount = listRecord
        .map((e) => e.isAdd ? e.amount : 0 - e.amount)
        .reduce((a, b) => a + b);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MyHomePage(
              listRecord: listRecord,
              amount: amount,
            ),
            ReportPage(),
            AccountPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _tabController.index = index;
            });
          },
        ),
      ),
    );
  }
}
