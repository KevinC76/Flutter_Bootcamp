import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finstagram/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedPageState();
  }
}

Map? post;

class _FeedPageState extends State<FeedPage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: _deviceHeight!,
      width: _deviceWidth!,
      child: _postListView(),
    );
  }

  Widget _postListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService!.getLatestPost(),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          List _posts = _snapshot.data!.docs.map((e) => e.data()).toList();
          print(_posts);
          return ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (BuildContext ccontext, int index) {
              Map _post = _posts[index];
              return Container(
                  height: _deviceHeight! * 0.30,
                  margin: EdgeInsets.symmetric(
                    vertical: _deviceHeight! * 0.02,
                    horizontal: _deviceWidth! * 0.05,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_post['image']),
                    ),
                  ));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
    // return ListView();
  }
}
