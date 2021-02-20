import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/model/wallet_model.dart';
import 'package:money_app/ui/record_create.dart';
import 'package:money_app/ui/wallet_list.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
import 'package:money_app/widgets/list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.listRecord, this.amount})
      : super(key: key);
  final List<Record> listRecord;
  final double amount;
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
  final HomeViewModel _homeViewModel = HomeViewModel.instance;

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
    return DefaultTabController(
      length: listMonth.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Record record = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddRecord()));
            setState(() {
              _homeViewModel.onCreateRecord(record);
            });
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () async {
              final Wallet wallet = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const WalletList()));
              HomeViewModel.instance.onPickWallet(wallet);
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
            subtitle: Text(
              "${StringHelper.instance.getMoneyText(widget.amount)} đ",
              style: const TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (context) {
                return listHomeMenu
                    .map(
                      (e) => PopupMenuItem<String>(
                        child: Text(e.name),
                      ),
                    )
                    .toList();
              },
              onSelected: (text) {
                print(text);
              },
            )
          ],
        ),
        body: widget.listRecord == null
            ? EmptyPage()
            : TabBarView(
                controller: _tabController,
                children: listMonth.map((e) => getPage(e)).toList(),
              ),
      ),
    );
  }

  Widget getPage(DateTime date) {
    final list = widget.listRecord
        .where((r) =>
            DateTime(r.createDate.year, r.createDate.month) ==
            DateTime(date.year, date.month))
        .toList();
    return list.isEmpty ? EmptyPage() : MyList(listRecord: list);
  }
}

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.note,
          size: 200,
          color: Colors.black26,
        ),
      ),
    );
  }
}
