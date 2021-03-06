import 'package:accordionflutter/module/accordion/datastore/dataStore.dart';
import 'package:accordionflutter/module/accordion/model/ampGenericObject.dart';
import 'package:accordionflutter/module/accordion/screens/detailed.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataStore dataStore = DataStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accordion'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    if (dataStore.dataRows.isEmpty) {
      return Center(
        child: Text('Loading data....'),
      );
    }
    return ListView.builder(
        itemCount: dataStore.numberOfItems(),
        itemBuilder: (context, index) =>
            _buildListTileWith(dataStore.itemAt(index)));
  }

  Widget _buildListTileWith(AMPGenericObject object) {
    return ListTile(
      title: AnimatedPadding(
        duration: Duration(
          milliseconds: 100
        ),
        padding: EdgeInsets.only(left: (10.0 * object.level)),
        child: Text(object.name),
      ),
      subtitle: AnimatedPadding(
        duration: Duration(
            milliseconds: 100
        ),
        padding: EdgeInsets.only(left: (10.0 * object.level)),
        child: Text(object.parentName),
      ),
      trailing: Icon(_trailingIconFor(object)),
      onTap: () => refresh(object),
    );
  }

  void refresh(AMPGenericObject object) {
    if (!object.canBeExpanded) {
      // Take to details
      navigateToDetailsWith(object);
      return;
    }
    if (object.isExpanded) {
      dataStore.collapseCellsFromIndexOf(object);
      setState(() {});
    } else {
      dataStore.fetchChildrenforParentAndExpand(object);
      setState(() {});
    }
  }

  void navigateToDetailsWith(AMPGenericObject object) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailedScreen(object: object)),
    );
  }
  IconData _trailingIconFor(AMPGenericObject object) {
    if (object.isExpanded) {
      return Icons.keyboard_arrow_down;
    } else if (object.canBeExpanded) {
      return Icons.keyboard_arrow_right;
    } else {
      return null;
    }
  }
}
