import 'package:cupertinobar_fab_centered_example/widget/content_list_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: ContentListWidget(
          urlImage:
              'https://res-5.cloudinary.com/enchanting/w_768,h_512,c_fill,f_auto/et-web/2015/06/1600-Iguazu-Falls-Argentina-shutterstock_172190801.jpg',
        ),
      );
}
