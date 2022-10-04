import 'package:edunciate/firebaseAccessor/personal_profile_firebase.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';

class EditProfilePage extends StatefulWidget {
  UserInfoItem _user;

  EditProfilePage(this._user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState(_user);
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserInfoItem _user;

  _EditProfilePageState(this._user);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 10, width: 10),
          Image(
            image: _user.image,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
              label: 'Pronouns',
              text: _user.pronouns,
              onChanged: (pronouns) {
                PersonalProfileFirebaseAccessor()
                    .updatePronouns(_user.id, pronouns);
                _user.pronouns = pronouns;
              }),
          const SizedBox(height: 24),
          TextFieldWidget(
              label: 'About',
              text: _user.about,
              maxLines: 5,
              onChanged: (about) {
                PersonalProfileFirebaseAccessor().updateBio(_user.id, about);
              })
        ],
      ));
}

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final Function(String) onChanged;

  const TextFieldWidget(
      {Key? key,
      this.maxLines = 1,
      required this.label,
      required this.text,
      required this.onChanged})
      : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState(onChanged);
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;
  Function(String) onChanged;

  _TextFieldWidgetState(this.onChanged);

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Josefin Sans',
                fontSize: 24.0,
              )),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: onChanged,
            maxLines: widget.maxLines,
          ),
        ],
      );
}
