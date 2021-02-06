import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record.dart';
import 'package:money_app/repository/record_repository.dart';
import 'package:money_app/widgets/list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin<MyHomePage>, TickerProviderStateMixin {
  List<Record> listRecord;
  double amount = 0;
  List<DateTime> listMonth = List<DateTime>.generate(100, (i) {
    final now = DateTime.now();
    final newNow = DateTime(now.year, now.month + 1);
    final newDate = DateTime(newNow.year, newNow.month - (i + 1));
    return newDate;
  });
  TabController _tabController;
  @override
  void initState() {
    listMonth.sort((a, b) => a.compareTo(b));
    final now = DateTime.now();
    final initialPage = listMonth
        .indexWhere((date) => date.year == now.year && date.month == now.month);
    _tabController = TabController(
        initialIndex: initialPage, vsync: this, length: listMonth.length);

    RecordRepository().getRecords().then((list) => {
          setState(() {
            list.sort((a, b) => b.createDate.compareTo(a.createDate));
            listRecord = list;
            amount = listRecord
                .map((e) => e.isAdd ? e.amount : 0 - e.amount)
                .reduce((a, b) => a + b);
          })
        });

    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: listMonth.length,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
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
              "${StringHelper.instance.getMoneyText(amount)} đ",
              style: const TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.access_alarms_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: listRecord == null
            ? EmptyPage()
            : TabBarView(
                controller: _tabController,
                children: listMonth.map((e) => getPage(e)).toList(),
              ),
      ),
    );
  }

  Widget getPage(DateTime date) {
    final list = listRecord
        .where((r) =>
            DateTime(r.createDate.year, r.createDate.month) ==
            DateTime(date.year, date.month))
        .toList();
    return list.isEmpty ? EmptyPage() : MyList(listRecord: list);
  }

  @override
  bool get wantKeepAlive => true;
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
