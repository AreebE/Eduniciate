import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/homepage/class_list_tile.dart';
import 'package:edunciate/joinAndCreateClass/create_class_screen.dart';
import 'package:edunciate/main.dart';
import 'package:edunciate/user_info_item.dart';
import 'package:flutter/material.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';

class ClassBody extends StatefulWidget {
  List<ClassList> _items;
  String userID;
  UserRole role;
  DisplayWidgetListener widgetListener;

  ClassBody(this._items, this.userID, this.role, this.widgetListener,
      {Key? key})
      : super(key: key);

  @override
  State<ClassBody> createState() =>
      _ClassBodyState(_items, role, userID, widgetListener);
}

class _ClassBodyState extends State<ClassBody> {
  List<ClassList> _items;
  UserRole role;
  String userID;
  DisplayWidgetListener widgetListener;

  late List<ClassList> _displayedItems;

  _ClassBodyState(this._items, this.role, this.userID, this.widgetListener) {
    _displayedItems = _items.toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (role == UserRole.owner) {
                  Navigator.push(widgetListener.getContext(),
                      MaterialPageRoute<String>(builder: (context) {
                    return CreateClassScreen(userID);
                  }));
                }
              },
              backgroundColor: CustomColorScheme.defaultColors
                  .getColor(CustomColorScheme.darkPrimary),
              child: const Icon(Icons.add),
            ),
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
