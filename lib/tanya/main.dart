import 'package:flutter/material.dart';
import "classlist.dart";
import 'package:paginated_search_bar/paginated_search_bar.dart';

void main() => runApp(MainBodyState());

class MainBodyState extends StatelessWidget {
  const MainBodyState({super.key});

@override
  Widget build(BuildContext context) {
    // Sushmita's code
    /*Container (
      child: PaginatedSearchBar<ExampleItem>(
        onSearch: ({
          required pageIndex,
          required pageSize,
          required searchQuery,
        }) async {
          // call your search API to return a list of items
          return [
            //ExampleItem(title: 'Item 0'),
            //ExampleItem(title: 'Item 1'),
          ];
        },
        itemBuilder: (
          context, {
            required item, required index,
          }) {return Text(item.title);}
        ));
        }*/



    return MaterialApp(
        home: Scaffold(
        /*appBar: AppBar( 
          Container (
            child: PaginatedSearchBar<ExampleItem>(
              onSearch: ({
                required pageIndex,
                required pageSize,
                required searchQuery,
              }) async {
                // call your search API to return a list of items
                return [
                  //ExampleItem(title: 'Item 0'),
                  //ExampleItem(title: 'Item 1'),
                ];
              },
              itemBuilder: (
                context, {
                  required item, required index,
                }) {return Text(item.title);}
        ));))*/
      
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: []),
      body: Column(
        children: [ClassList("Model United Nations", "A North Creek Club.", Colors.blue),
      ClassList("Environmental Action Club", "One Earth. One Home.", Colors.green),
      ClassList("FBLA", "Future Business Leaders of America.", Colors.purple)],)
    ));
  }
}