import 'package:cupertinobar_fab_centered_example/widget/content_list_widget.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Mail'),
        ),
        body: ContentListWidget(
          urlImage:
              'https://mediagen.captureone.com/media/h3uh2rws/capture-one-raw-photo-editor-fujifilm-feature-image-quality.png?width=1500&upscale=false',
        ),
      );
}
