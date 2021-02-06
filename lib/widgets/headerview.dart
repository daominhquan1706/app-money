import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_app/helper/string_helper.dart';

class HeaderView extends StatelessWidget {
  final DateTime date;
  final double amount;

  const HeaderView({Key key, this.date, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                "${date.day}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            title: Text(DateFormat('EEEE').format(date)),
            subtitle: Text(DateFormat('MMMM yyyy').format(date)),
            trailing: Text(StringHelper.instance.getMoneyText(amount)),
          ),
          const Divider(
            color: Colors.black12,
            height: 0,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
