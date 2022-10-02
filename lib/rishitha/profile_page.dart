import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10, width: 10),
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 24),
            buildAbout(user),
          ],
        ));
  }
}

Widget buildName(User user) => Column(children: [
      Text(user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Josefin Sans',
            fontSize: 24.0,
          )),
      const SizedBox(height: 4),
      Text(user.grade,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Lato',
          )),
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

Widget buildAbout(User user) => Container(
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
      leading: BackButton(),
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 58, 27, 103),
      actions: []);
}

class User {
  final String imagePath;
  final String name;
  final String grade;
  final String pronouns;
  final String email;
  final String about;

  const User({
    required this.imagePath,
    required this.name,
    required this.grade,
    required this.pronouns,
    required this.email,
    required this.about,
  });
}

class UserPreferences {
  static const myUser = User(
      imagePath:
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
      name: "Yelena Belova",
      grade: "12th grade",
      pronouns: "she/her/hers",
      email: "yelenabelova@gmail.com",
      about:
          "A cool person. I am a former assasin. Well, formerly not on my own terms, the assasin part is debatable. My sister is Natasha Romanoff, and for a while, my sworn enemy was Clint Barton.");
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
