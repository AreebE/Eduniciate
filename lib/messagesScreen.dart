// // main.dart
// import 'package:flutter/material.dart';
// import 'package:bubble/bubble.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Bubble(
//               margin: const BubbleEdges.only(top: 10),
//               alignment: Alignment.topRight,
//               nipWidth: 8,
//               nipHeight: 24,
//               nip: BubbleNip.rightTop,
//               color: Colors.purple,
//               child: const Text('Hello, how are you?',
//                   textAlign: TextAlign.right, style: TextStyle(fontSize: 17)),
//             ),
//             Bubble(
//               margin: const BubbleEdges.only(top: 10),
//               alignment: Alignment.topLeft,
//               nipWidth: 8,
//               nipHeight: 24,
//               nip: BubbleNip.leftTop,
//               child: const Text(
//                 'I am fine. And you?',
//                 style: TextStyle(fontSize: 17),
//               ),
//             ),
//             Bubble(
//               margin: const BubbleEdges.only(top: 10),
//               alignment: Alignment.topRight,
//               nipWidth: 30,
//               nipHeight: 10,
//               nip: BubbleNip.rightTop,
//               color: Colors.purple,
//               child: const Text('I am sick',
//                   textAlign: TextAlign.right, style: TextStyle(fontSize: 17)),
//             ),
//             Bubble(
//               margin: const BubbleEdges.only(top: 10),
//               alignment: Alignment.topLeft,
//               nipWidth: 30,
//               nipHeight: 10,
//               nip: BubbleNip.leftTop,
//               child: const Text('Do you need help?',
//                   style: TextStyle(fontSize: 17)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget creatCodeAlert(BuildContext context) {
//   return AlertDialog(
//     title: const Text('AlertDialog Title'),
//     content: const Text('AlertDialog description'),
//     actions: <Widget>[
//       TextButton(
//         onPressed: () => Navigator.pop(context, 'Cancel'),
//         child: const Text('Cancel'),
//       ),
//       TextButton(
//         onPressed: () => Navigator.pop(context, 'OK'),
//         child: const Text('OK'),
//       ),
//     ],
//   );
// }

// // Widget createBubble(String text, bool incoming){
// //   return Bubble (
// //     margin: const BubbleEdges.only(top: 10),
// //     Alignment n = Alignment.topRight,
// //     if (incoming == true) {
// //       Alignment a = Alignment.topLeft()
// //     }

// //     nipWidth: 30,
// //     nipHeight: 10,
// //     nip: BubbleNip.rightTop,
// //     color: Colors.purple,
// //     child: const Text(text,
// //     textAlign: TextAlign.right, style: TextStyle(fontSize: 17)),
// //   );
// // }

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class messagingPage extends StatelessWidget {
  const messagingPage({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: ChatPage(),
      );
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAtachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: "",
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: "",
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "",
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }
}
