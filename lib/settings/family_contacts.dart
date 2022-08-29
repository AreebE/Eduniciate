// Areeb Emran
// Family Contacts

// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/font_standards.dart';
import 'package:edunciate/settings/items/family_contact_item.dart';
import 'package:edunciate/settings/res/sizes.dart';
import 'package:edunciate/settings/res/strings.dart';

class FamilyContactDisplay extends StatefulWidget {
  final CustomColorScheme colorScheme;

  const FamilyContactDisplay(this.colorScheme, {Key? key}) : super(key: key);

  @override
  State<FamilyContactDisplay> createState() =>
      _FamilyContactDisplayState(colorScheme);
}

class _FamilyContactDisplayState extends State<FamilyContactDisplay> {
  final CustomColorScheme colorScheme;
  List<FamilyContact> sampleContacts = [
    FamilyContact("First", "Tester", Relationship.mom, "(555) 425 - \n1023"),
    FamilyContact("Second", "Tester", Relationship.dad, "(555) 531 - \n2412"),
    FamilyContact(
        "Third", "Rater", Relationship.guardian, "(555) 032 - \n6932"),
    FamilyContact("False", "Second", Relationship.parent, "(555) 693 - \n5823"),
    FamilyContact("False", "Second", Relationship.parent, "(555) 693 - \n5823"),
  ];
  _FamilyContactDisplayState(this.colorScheme);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.none, Sizes.smallMargin, Sizes.none, Sizes.smallMargin),
          child: Text(StringList.familyContacts,
              textDirection: TextDirection.ltr,
              style: FontStandards.getTextStyle(
                colorScheme,
                Style.header,
                FontSize.heading,
              )),
        ),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        ),
        FractionallySizedBox(
          widthFactor: Sizes.largeRowSpace,
          alignment: Alignment.center,
          child: Container(
              decoration: BoxDecoration(
                  color: colorScheme.getColor(CustomColorScheme.lightPrimary),
                  border: Border.all(
                      color:
                          colorScheme.getColor(CustomColorScheme.darkPrimary),
                      width: Sizes.borderWidth)),
              child: Column(
                children: [
                  SizedBox(
                      height: Sizes.maxContactBoxHeight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: getContacts(),
                        ),
                      )),
                  Divider(
                    height: Sizes.dividerHeight,
                    thickness: Sizes.dividerThickness,
                    color: colorScheme.getColor(CustomColorScheme.darkPrimary),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(Sizes.smallMargin),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Sizes.extremeRoundedBorder)),
                            primary: colorScheme
                                .getColor(CustomColorScheme.normalText)),
                        onPressed: addContact,
                        icon: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: Sizes.addSize,
                              color: colorScheme.getColor(CustomColorScheme
                                  .backgroundAndHighlightedNormalText),
                            ),
                            Icon(
                              Icons.add_outlined,
                              size: Sizes.plusSize,
                              color: colorScheme
                                  .getColor(CustomColorScheme.normalText),
                            ),
                          ],
                        ),
                        label: Text(
                          StringList.addMember,
                          textAlign: TextAlign.center,
                          style: FontStandards.getTextStyle(
                              colorScheme, Style.brightNorm, FontSize.medium),
                        ),
                      ))
                ],
              )),
        ),
        const SizedBox(
          height: Sizes.smallSpacerWidth,
        )
      ],
    );
  }

  List<Widget> getContacts() {
    List<Widget> widgets = [];
    for (int i = 0; i < StringList.contactItems.length; i++) {
      widgets.add(constructColumn(i));
    }
    return widgets;
  }

  Widget constructColumn(int position) {
    switch (position) {
      case 0:
        return getItems(StringList.name, position);
      case 1:
        return getItems(StringList.relationship, position);
      case 2:
        return getItems(StringList.number, position);
      case 3:
        return getItems(StringList.options, position);
    }
    return const Text("");
  }

  Container getItems(int category, int position) {
    Color backgroundColor = colorScheme.getColor((position % 2 == 0)
        ? CustomColorScheme.lightPrimary
        : CustomColorScheme.lightVariant);
    Color dividerColor = colorScheme.getColor((position % 2 == 0)
        ? CustomColorScheme.lightVariant
        : CustomColorScheme.lightPrimary);
    Style fontStyle = (position % 2 == 0) ? Style.darkVarBold : Style.darkBold;
    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            height: Sizes.contactHeight,
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                    bottom: BorderSide(
                        color: dividerColor, width: Sizes.dividerThickness))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(Sizes.smallMargin,
                  Sizes.smallMargin, Sizes.smallMargin, Sizes.smallMargin),
              child: Text(
                StringList.contactItems.elementAt(category),
                textAlign: TextAlign.center,
                style: FontStandards.getTextStyle(
                    colorScheme, fontStyle, FontSize.medium),
              ),
            )),
      ],
    );
    for (int i = 0; i < sampleContacts.length; i++) {
      // print("E");
      FamilyContact current = sampleContacts.elementAt(i);

      Widget e = const Text("");
      switch (category) {
        case StringList.name:
          e = Text(
            current.getName(),
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                colorScheme, fontStyle, FontSize.small),
          );
          break;

        case StringList.relationship:
          e = Text(
            current.getRelationship(),
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                colorScheme, fontStyle, FontSize.small),
          );
          break;

        case StringList.number:
          e = Text(
            current.getPhoneNumber(),
            textAlign: TextAlign.center,
            style: FontStandards.getTextStyle(
                colorScheme, fontStyle, FontSize.small),
          );
          break;

        case StringList.options:
          e = Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: colorScheme.getColor(CustomColorScheme.change),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Sizes.roundedBorder))),
                onPressed: () => changeContact(i),
                child: Text(
                  StringList.change,
                  textAlign: TextAlign.center,
                  style: FontStandards.getTextStyle(
                      colorScheme, fontStyle, FontSize.small),
                ),
              ),
              const SizedBox(
                width: Sizes.smallMargin,
              ),
              // Deny button
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(Sizes.smallMargin),
                child: Material(
                  shape: const CircleBorder(),
                  color: colorScheme.getColor(CustomColorScheme.delete),
                  child: IconButton(
                    onPressed: () => deleteContact(i),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.delete,
                      size: Sizes.addSize,
                      color: colorScheme.getColor(
                          CustomColorScheme.backgroundAndHighlightedNormalText),
                    ),
                  ),
                ),
              )
            ],
          );
          break;
      }
      Container c = Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: dividerColor, width: Sizes.dividerThickness))),
        padding: const EdgeInsets.only(
            left: Sizes.mediumMargin, right: Sizes.mediumMargin),
        child: e,
      );
      column.children.add(SizedBox(height: Sizes.contactHeight, child: c));
    }
    return Container(
      alignment: Alignment.center,
      color: backgroundColor,
      child: IntrinsicWidth(
        child: column,
      ),
    );
  }

  void changeContact(int position) {}

  void deleteContact(int position) {}

  void addContact() {}
}
