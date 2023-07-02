import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            'プロフィールを設定して、今すぐチャットを始めよう！',
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                  fixedSize: const Size.fromRadius(100),
                  backgroundColor: Colors.pink[100],
                ),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/girl_001.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Image.asset('images/girl_001.png')
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              '※今後アップデート予定',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
