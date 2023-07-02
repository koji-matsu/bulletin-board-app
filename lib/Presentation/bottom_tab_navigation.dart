import 'package:chat_app/Presentation/AIChat/ai_chat_page.dart';
import 'package:chat_app/Presentation/Chat/chat_page.dart';
import 'package:chat_app/Presentation/Profile/profile_page.dart';
import 'package:chat_app/Presentation/Settings/settings_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_animate/animation/pulse_animation.dart';
import 'package:easy_animate/enum/animate_type.dart';
import 'package:flutter/material.dart';

class BottomTabPage extends StatefulWidget {
  const BottomTabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTabPage> {
  int _currentIndex = 0;
  final _pageWidgets = [
    _PageWidgets(
      title: 'プロフィール',
      widget: const ProfilePage(),
    ),
    _PageWidgets(
      title: 'チャット',
      widget: const ChatPage(),
    ),
    _PageWidgets(
      title: 'AIチャット',
      widget: const AIChatPage(),
    ),
    _PageWidgets(
      title: '設定',
      widget: const SettingsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        title: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              'images/pencil.png',
            ),
            Text(
              _pageWidgets[_currentIndex].title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: SizedBox.shrink(),
        ),
      ),
      body: _pageWidgets[_currentIndex].widget,
      bottomNavigationBar: PulseAnimation(
        animateType: AnimateType.loop,
        child: ConvexAppBar(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.red, Colors.green, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          style: TabStyle.reactCircle,
          items: const [
            TabItem(icon: Icons.supervisor_account_sharp, title: 'プロフィール'),
            TabItem(icon: Icons.chat, title: 'チャット'),
            TabItem(icon: Icons.android, title: 'Chat GPT'),
            TabItem(icon: Icons.build, title: '設定'),
          ],
          onTap: (int index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}

class _PageWidgets {
  _PageWidgets({
    required this.title,
    required this.widget,
  });

  String title;
  Widget widget;
}
