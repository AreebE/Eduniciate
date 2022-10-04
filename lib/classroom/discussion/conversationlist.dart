import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget{
  String name;
  String lastmessageText;
  String time;
  bool isMessageRead;
  ConversationList({required this.name,required this.lastmessageText,required this.time,required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Column(
          children: <Widget> [
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.purple,
                        maxRadius: 20,
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.name, style: TextStyle(fontSize: 16),),
                              SizedBox(height: 6,),
                              Text(widget.lastmessageText,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(widget.time,style: TextStyle(fontSize: 12,fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
              ],
            ),
            SizedBox(height:6),
            Divider(color: Colors.deepPurple)
          ]
        )
      ),
    );
  }
}