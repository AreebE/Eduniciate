import 'dart:typed_data';

import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/main.dart';
import 'package:edunciate/personal_profile/edit_profile_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  UserInfoItem _user;
  DisplayWidgetListener widgetListener;

  ProfilePage(this._user, this.widgetListener);
  @override
  _ProfilePageState createState() => _ProfilePageState(_user, widgetListener);
}

class _ProfilePageState extends State<ProfilePage> {
  UserInfoItem _user;
  DisplayWidgetListener widgetListener;

  _ProfilePageState(this._user, this.widgetListener);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10, width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: CustomColorScheme.defaultColors.getColor(
                      CustomColorScheme.backgroundAndHighlightedNormalText)),
              child: Image(image: _user.image),
              onPressed: () {
                Navigator.push(
                  widgetListener.getContext(),
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePage(_user, widgetListener)),
                );
              },
            ),
            const SizedBox(height: 24),
            buildName(_user),
            const SizedBox(height: 24),
            buildAbout(_user),
          ],
        ));
  }
}

Widget buildName(UserInfoItem user) => Column(children: [
      Text(user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Josefin Sans',
            fontSize: 24.0,
          )),
      const SizedBox(height: 4),
      const SizedBox(height: 4),
      Text(user.pronouns,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Lato',
          )),
      const SizedBox(height: 4),
      Text(user.email,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Lato',
          )),
    ]);

Widget buildAbout(UserInfoItem user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('About',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Josefin Sans',
            fontSize: 24.0,
          )),
      const SizedBox(height: 16),
      Text(user.about,
          style: TextStyle(
            fontSize: 16,
            height: 1.4,
            color: Colors.black,
            fontFamily: 'Lato',
          )),
    ]));

AppBar buildAppBar(BuildContext context) {
  return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 58, 27, 103),
      actions: []);
}

class UserInfoItem {
  late MemoryImage image;
  String id;
  String name;
  String pronouns;
  String email;
  String about;

  UserInfoItem({
    required Uint8List imageBytes,
    required this.id,
    required this.name,
    required this.pronouns,
    required this.email,
    required this.about,
  }) {
    image = MemoryImage(imageBytes);
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color.fromARGB(255, 58, 27, 103);

    return Center(
        child: Stack(children: [
      buildImage(),
      Positioned(
        bottom: 0,
        right: 4,
        child: buildEditIcon(color),
      )
    ]));
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
        child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: image,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              child: InkWell(
                onTap: onClicked,
              ),
            )));
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: Icon(isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white, size: 20),
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
