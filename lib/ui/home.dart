import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_app/constants/constant.dart';
import 'package:money_app/helper/dialog_helper.dart';
import 'package:money_app/helper/string_helper.dart';
import 'package:money_app/model/record_model.dart';
import 'package:money_app/services/login_manager.dart';
import 'package:money_app/ui/list_wallet.dart';
import 'package:money_app/ui/record_create.dart';
import 'package:money_app/ui/widgets/empty_page.dart';
import 'package:money_app/ui/widgets/list_record_widget.dart';
import 'package:money_app/view_models/home_viewmodel.dart';
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
  final HomeViewModel _homeViewModel = HomeViewModel();

  _MyHomePageState();
  @override
  void initState() {
    DialogHelper.showLoading();
    _homeViewModel.fetchData().then((value) => DialogHelper.dismissLoading());
    listMonth.sort((a, b) => a.compareTo(b));
    final now = DateTime.now();
    final initialPage = listMonth
        .indexWhere((date) => date.year == now.year && date.month == now.month);
    _tabController = TabController(
        initialIndex: initialPage, vsync: this, length: listMonth.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => _homeViewModel,
      child: Consumer<HomeViewModel>(builder: (context, value, child) {
        return DefaultTabController(
          length: listMonth.length,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).push<Record>(
                  MaterialPageRoute(
                    builder: (context) =>
                        AddEditRecord(homeViewModel: _homeViewModel),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              titleSpacing: 0,
              // leading: IconButton(
              //   icon: const CircleAvatar(
              //     backgroundColor: Colors.white,
              //     child: FaIcon(FontAwesomeIcons.wallet),
              //   ),
              //   onPressed: () async {
              //     final Wallet wallet =
              //         await Navigator.of(context).push<Wallet>(
              //       MaterialPageRoute(
              //         builder: (context) => const ListWalletPage(),
              //       ),
              //     );
              //     if (wallet != null) {
              //       _homeViewModel.onPickWallet(wallet);
              //     }
              //   },
              // ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: listMonth
                    .map((e) => Tab(text: DateFormat('MMMM yyyy').format(e)))
                    .toList(),
              ),
              title: ListTile(
                title: const Text(
                  "Tổng",
                  style: TextStyle(color: Colors.white54),
                ),
                subtitle:
                    Consumer<HomeViewModel>(builder: (context, value, child) {
                  return Text(
                    "${StringHelper.instance.getMoneyText(value.amountListRecord)} đ",
                    style: const TextStyle(color: Colors.white, fontSize: 23),
                  );
                }),
              ),
              actions: [
                PopupMenuButton<String>(
                  key: const ValueKey("popUpMenu"),
                  itemBuilder: (context) {
                    return listHomeMenu
                        .map(
                          (item) => PopupMenuItem<String>(
                            key: ValueKey(item.key),
                            value: item.name,
                            child: Text(item.name),
                          ),
                        )
                        .toList();
                  },
                  onSelected: (text) {
                    switch (text) {
                      case "Đăng xuất":
                        LoginManager.instance.logout();
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
      }),
    );
  }

  Widget getPage(DateTime date, List<Record> listRecord) {
    final list = listRecord
        .where((r) =>
            DateTime(r.createDate.toDate().year, r.createDate.toDate().month) ==
            DateTime(date.year, date.month))
        .toList();
    return list.isEmpty ? EmptyPage() : ListRecordWidget(listRecord: list);
  }
}
