import 'package:flutter/material.dart';
import 'package:money_app/ui/report.dart';
import 'package:money_app/ui/splash_screen.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:provider/provider.dart';

import 'account.dart';
import 'home.dart';

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
        if (value?.listRecord == null) {
          return SplashScreen();
        }
        return _buildMainLayout();
      },
    );
  }

  Widget _buildMainLayout() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const MyHomePage(),
            const ReportPage(),
            AccountPage(),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Lịch sử',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.business),
        //       label: 'Report',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.account_circle_sharp),
        //       label: 'Account',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   unselectedItemColor: Colors.grey,
        //   unselectedLabelStyle: const TextStyle(color: Colors.grey),
        //   //showUnselectedLabels: true,
        //   onTap: (index) {
        //     setState(() {
        //       _selectedIndex = index;
        //       _tabController.index = index;
        //     });
        //   },
        // ),
      ),
    );
  }
}
