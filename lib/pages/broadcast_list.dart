import 'package:flutter/material.dart';
import 'package:project_moon_1/widgets/custom_button.dart';

class BroadcastList extends StatefulWidget {
  @override
  _BroadcastListState createState() => _BroadcastListState();
}

class _BroadcastListState extends State<BroadcastList> {
  List<int> bottom = [0];
  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey('bottom-sliver-list');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Press on the plus to add items above and below'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              bottom.add(bottom.length);
            });
          },
        ),
      ),
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: CustomButton(
                    onPressed: () {
                      print("Tapped Me");
                    },
                  ),
                );
              },
              childCount: bottom.length,
            ),
          ),
        ],
      ),
    );
  }
}
