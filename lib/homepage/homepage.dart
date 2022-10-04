import 'package:edunciate/homepage/class_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';

class ClassBody extends StatefulWidget {
  List<ClassList> _items;

  ClassBody(this._items, {Key? key}) : super(key: key);

  @override
  State<ClassBody> createState() => _ClassBodyState(_items);
}

class _ClassBodyState extends State<ClassBody> {
  List<ClassList> _items;
  late List<ClassList> _displayedItems;

  _ClassBodyState(this._items) {
    _displayedItems = _items.toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
      (SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            SizedBox(height: 10),
            Container(
              child: PaginatedSearchBar<ClassList>(
                hintText: 'Search for a group to join here.',
                onSearch: ({
                  required pageIndex,
                  required pageSize,
                  required searchQuery,
                }) async {
                  // Call your search API to return a list of items
                  _displayedItems = [];
                  for (int i = 0; i < _items.length; i++) {
                    ClassList current = _items.elementAt(i);
                    if (current.title.contains(searchQuery)) {
                      _displayedItems.add(current);
                    }
                  }

                  return _displayedItems;
                },
                itemBuilder: (
                  context, {
                  required item,
                  required index,
                }) {
                  return Text(item.title);
                },
              ),
            ),
          ]))),

      /*bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: []),*/
      Column(
        children: _displayedItems,
      )
    ])));
  }
}

class ExampleItem {
  final String title;
  ExampleItem(
    this.title,
  );
}
