import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    child: FlutterLogo(),
                  ),
                  Text("User Name"),
                  Text("useremail@gmail.com"),
                ],
              ),
            ),
            _buildSettingItem(Icons.account_circle_sharp, "Menu 1"),
            _buildSettingItem(Icons.sort, "Menu 2"),
            _buildSettingItem(Icons.note, "Menu 3"),
            _buildSettingItem(Icons.admin_panel_settings_outlined, "Menu 4"),
            _buildSettingItem(Icons.apps_outlined, "Menu 5"),
            _buildSettingItem(Icons.account_circle_sharp, "Menu 6"),
            _buildSettingItem(Icons.attachment_rounded, "Menu 7"),
            _buildSettingItem(Icons.assistant_direction, "Menu 8"),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title) {
    return Column(
      children: [
        Divider(
          indent: 70,
        ),
        ListTile(
          leading: Icon(
            icon,
            size: 35,
          ),
          title: Text(title),
        ),
      ],
    );
  }
}
