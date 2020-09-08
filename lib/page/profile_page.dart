import 'package:cupertinobar_fab_centered_example/widget/content_list_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: ContentListWidget(
          urlImage:
              'https://thatcovergirl.com/wp-content/uploads/2015/12/winter.jpg',
        ),
      );
}
