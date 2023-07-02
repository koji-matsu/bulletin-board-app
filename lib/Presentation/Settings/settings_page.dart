import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Text(
        '※今後アップデート予定',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
