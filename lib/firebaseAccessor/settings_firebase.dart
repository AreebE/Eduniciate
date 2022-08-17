import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunciate/color_scheme.dart';
import 'package:edunciate/firebaseAccessor/firebase_listener.dart';
import 'package:edunciate/settings/items/event.dart';
import 'package:edunciate/settings/items/family_contact_item.dart';
import 'package:edunciate/settings/items/permission.dart';
import 'package:edunciate/settings/items/settingsItem.dart';
import 'package:edunciate/settings/items/time_range.dart';

class FirebaseSettingsAccessor {
  static const String usersCollection = "Users";
  static const String absenceDayKey = "absentDays";
  static const String contactKey = "contacts";
  static const String languageKey = "language";
  static const String workHoursKey = "workHours";

  static const String absenceCollection = "Absences";
  static const String dateKey = "date";
  static const String reasonKey = "reason";

  static const String colorSchemeCollections = "ColorSchemes";
  static const String backgroundKey = "background";
  static const String backgroundTextKey = "backgroundText";
  static const String changeKey = "change";
  static const String linkKey = "link";
  static const String primaryKey = "primary";
  static const String primaryVarKey = "primaryVar";
  static const String removalKey = "removal";
  static const String secondaryKey = "secondary";
  static const String secondarySecondVarKey = "secondarySecondVar";
  static const String secondaryVarKey = "secondaryVar";
  static const String suggestionKey = "suggestion";

  static const String rangeCollections = "Ranges";
  static const String dayKey = "day";
  static const String endTimeKey = "endTime";
  static const String startTimeKey = "startTime";

  static const String contactCollections = "Contacts";
  static const String familyNameKey = "familyName";
  static const String phoneNumberKey = "phoneNumber";
  static const String emailKey = "email";
  static const String relationshipStatusKey = "relationshipStatus";

  late FirebaseFirestore storage;

  FirebaseSettingsAccessor() {
    storage = FirebaseFirestore.instance;
  }

  void getSettingsInfo(
      String personID,
      List<Permission> permissions,
      List<FamilyContact> contacts,
      List<List<TimeRange>> timeRanges,
      List<Event> events,
      List<CustomColorScheme> scheme,
      List<String> language,
      FirebaseListener listener) {
    storage.collection(usersCollection).doc(personID).get().then((value) => () {
          if (!value.exists) {
            listener.onFailure("Could not find you. :(");
          }
          language.removeAt(0);
          language.add(value.get(languageKey));

          List<DocumentReference> contactKeys = value.get(contactKey);
          loadContacts(contacts, contactKeys, listener);

          List<DocumentReference> timeRangeKeys = value.get(workHoursKey);
          loadTimeRanges(timeRanges, timeRangeKeys, listener);

          List<DocumentReference> eventKeys = value.get(absenceDayKey);
          loadEvents(events, eventKeys, listener);
        });
  }

  void loadContacts(List<FamilyContact> contacts,
      List<DocumentReference> contactIDs, FirebaseListener listener) {
    int contactsAdded = 0;
    for (int i = 0; i < contactIDs.length; i++) {
      String specContactKey = contactIDs.elementAt(i).id;
      storage
          .collection(contactCollections)
          .doc(specContactKey)
          .get()
          .then((contactValue) => () {
                if (!contactValue.exists) {
                  listener.onFailure("Could not find all contacts. :(");
                }

                String fullName = contactValue.get(familyNameKey);
                String relationshipStatus =
                    contactValue.get(relationshipStatusKey);
                String unformatedPhoneNumber = contactValue.get(phoneNumberKey);
                String email = contactValue.get(emailKey);

                String firstName = fullName.substring(0, fullName.indexOf(';'));
                String lastName = fullName.substring(fullName.indexOf(';') + 1);

                String formatedPhoneNumber =
                    "(${unformatedPhoneNumber.substring(0, 3)}) ${unformatedPhoneNumber.substring(3, 6)} - \n${unformatedPhoneNumber.substring(6)}";
                contacts.add(FamilyContact(
                    firstName,
                    lastName,
                    FamilyContact.relation(relationshipStatus),
                    formatedPhoneNumber));
                contactsAdded++;
                if (contactsAdded == contactIDs.length) {
                  listener.onSuccess();
                }
              });
    }
  }

  void loadTimeRanges(List<List<TimeRange>> timeRanges,
      List<DocumentReference> timeRangeKeys, FirebaseListener listener) {
    int timeRangesAdded = 0;
    for (int i = 0; i < timeRangeKeys.length; i++) {
      storage
          .collection(rangeCollections)
          .doc(timeRangeKeys.elementAt(i).id)
          .get()
          .then((value) => () {
                if (!value.exists) {
                  listener.onFailure("Could not find time ranges. :(");
                }
              });
    }
  }

  void loadEvents(List<Event> events, List<DocumentReference> eventKeys,
      FirebaseListener listener) {}
}
