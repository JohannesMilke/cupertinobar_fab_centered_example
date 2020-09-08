import 'package:cupertinobar_fab_centered_example/widget/content_list_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: ContentListWidget(
          urlImage:
              'https://www.gesundheitstrends.com/wp-content/uploads/2019/09/herbst-allergie.jpg',
        ),
      );
}
