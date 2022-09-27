import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:collection';
import 'package:paginated_search_bar/paginated_search_bar.dart';



class MyCustomFormU extends StatefulWidget {
  const MyCustomFormU({super.key});
  @override
  State<MyCustomFormU> createState() => _userMessages();
}


class _userMessages extends State<MyCustomFormU>{

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hebbo = <Widget>[];
    for (var i = 0; i < 10; i++) {
      hebbo.add(new Container(height: 30, child: ListTile(tileColor: Colors.purple)));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row (
        children: <Widget> [
          PaginatedSearchBar<ExampleItem>(
  onSearch: ({
    required pageIndex,
    required pageSize,
    required searchQuery,
  }) async {
    // Call your search API to return a list of items
    return [
      ExampleItem(title: 'Item 0'),
      ExampleItem(title: 'Item 1'),
    ];
  },
  itemBuilder: (
    context, {
    required item,
    required index,
  }) {
    return Text(item.title);
  },
)
        ]
      ),
         listTile()
      ]
    );
  }
}

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}
 

Widget listTile(){
  final child = <Widget>[];
  child.add(Container(height: 15));
  for (var i = 0; i < 5; i++) {
    child.add(PeopleTile("your name"));
  }
  return Column (
      children: child
  );
 }

//Code for the listings of people
class PeopleTile extends StatelessWidget {
  PeopleTile(String name);

  
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
              ),
            ],
          ),
          title: Text('name',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Color.fromARGB(255, 58, 27, 103),
                fontFamily: 'Lato',
                fontSize: 18.0,
              )),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: Color.fromARGB(255, 58, 27, 103), width: 1),
              borderRadius: BorderRadius.circular(5)),
          trailing: GestureDetector(
              child: const Icon(CupertinoIcons.ellipsis),
            )),
    );
  }


  Widget buildOwnerIcon(Color color) => buildCircle(
      color: Colors.grey,
      all: 0.5,
      child: buildCircle(
        color: color,
        all: 0.5,
        child:
            Icon(Icons.star, color: Color.fromARGB(255, 58, 27, 103), size: 10),
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ));
}


