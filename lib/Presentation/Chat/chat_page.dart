import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:like_button/like_button.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      final documentData =
                          document.data()! as Map<String, dynamic>;
                      return Row(
                        children: [
                          LikeButton(
                            //isLiked: true,
                            size: 70,
                            likeBuilder: (bool isLiked) {
                              return Image.asset(
                                'images/girl_001.png',
                                color: isLiked ? null : Colors.grey,
                              );
                            },
                          ),
                          Expanded(
                            child: Card(
                              child: Material(
                                color: Colors.lightGreen.shade100,
                                child: InkWell(
                                  onTap: () {
                                    CollectionReference posts =
                                        FirebaseFirestore.instance
                                            .collection('posts');
                                    posts.doc(document.id).delete();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              documentData['user'] ?? '',
                                              style: const TextStyle(
                                                color: Colors.indigoAccent,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              documentData['timestamp']
                                                  .toDate()
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.indigoAccent,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 10.0,
                                          thickness: 0.8,
                                          color: Colors.lightGreen,
                                        ),
                                        Text(
                                          documentData['content'] ?? '',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
              left: 30.0,
              bottom: 40.0,
            ),
            child: TextField(
              controller: _textEditingController,
              onSubmitted: _onSubmitted,
              enabled: true,
              maxLength: 50,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              //maxLines: 3,
              decoration: const InputDecoration(
                icon: Icon(Icons.speaker_notes),
                hintText: '投稿内容を記載します',
                labelText: '投稿 * ',
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onSubmitted(String content) {
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    posts
        .add({'user': 'user', 'content': content, 'timestamp': DateTime.now()});

    /// 入力欄をクリアにする
    _textEditingController.clear();
  }
}
