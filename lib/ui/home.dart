import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/ui/record_create.dart';
import 'package:money_app/ui/wallet_list.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/view_models/login_viewmodel.dart';
import 'package:money_app/widgets/empty_page.dart';
import 'package:money_app/widgets/list.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<DateTime> listMonth = List<DateTime>.generate(12, (i) {
    final now = DateTime.now();
    final newNow = DateTime(now.year, now.month + 1);
    final newDate = DateTime(newNow.year, newNow.month - (i + 1));
    return newDate;
  });
  TabController _tabController;
  HomeViewModel _homeViewModel;

  _MyHomePageState();
  @override
  void initState() {
    listMonth.sort((a, b) => a.compareTo(b));
    final now = DateTime.now();
    final initialPage = listMonth
        .indexWhere((date) => date.year == now.year && date.month == now.month);
    _tabController = TabController(
        initialIndex: initialPage, vsync: this, length: listMonth.length);

    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    _homeViewModel ??= Provider.of<HomeViewModel>(context);

    return DefaultTabController(
      length: listMonth.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push<Record>(MaterialPageRoute(
                builder: (context) => AddRecord(
                      homeViewModel: _homeViewModel,
                    )));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "${_homeViewModel.currentWallet?.id ?? ""}",
                style: const TextStyle(color: Colors.black),
              ),
            ),
            onPressed: () async {
              final Wallet wallet = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const WalletList()));
              if (wallet != null) {
                setState(() {
                  _homeViewModel.onPickWallet(wallet);
                });
              }
            },
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: listMonth
                .map((e) => Tab(text: DateFormat('MMMM yyyy').format(e)))
                .toList(),
          ),
          title: ListTile(
            title: const Text(
              "Total",
              style: TextStyle(color: Colors.white54),
            ),
            subtitle: Consumer<HomeViewModel>(builder: (context, value, child) {
              return Text(
                "${StringHelper.instance.getMoneyText(value.amountListRecord)} đ",
                style: const TextStyle(color: Colors.white, fontSize: 23),
              );
            }),
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (context) {
                return listHomeMenu
                    .map(
                      (e) => PopupMenuItem<String>(
                        value: e.name,
                        child: Text(e.name),
                      ),
                    )
                    .toList();
              },
              onSelected: (text) {
                switch (text) {
                  case "Sign Out":
                    LoginViewModel().instance.logout();
                    break;
                  default:
                    break;
                }
              },
            )
          ],
        ),
        body: Consumer<HomeViewModel>(builder: (context, value, child) {
          return value.listRecord == null
              ? EmptyPage()
              : TabBarView(
                  controller: _tabController,
                  children: listMonth
                      .map((e) => getPage(e, value.listRecord))
                      .toList(),
                );
        }),
      ),
    );
  }

  Widget getPage(DateTime date, List<Record> listRecord) {
    final list = listRecord
        .where((r) =>
            DateTime(r.createDate.year, r.createDate.month) ==
            DateTime(date.year, date.month))
        .toList();
    return list.isEmpty ? EmptyPage() : MyList(listRecord: list);
  }
}
