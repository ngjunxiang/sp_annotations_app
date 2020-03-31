import 'package:flutter/material.dart';

import '../widgets/annotations_widget.dart';
import '../widgets/group_widget.dart';

class MainScreen extends StatelessWidget {
  Widget _buildHeader(BuildContext context, double availableHeight) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Text(
        'SP Annotations App',
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;

    final pageBody = SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(context, availableHeight),
            GroupWidget(),
            AnnotationsWidget(),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: pageBody,
      ),
    );
  }
}
