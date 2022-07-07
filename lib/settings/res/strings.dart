class StringList {
  static const String language = "Language:";
  static const String current = "Current";
  static const String change = "Change";
  static const String changeLang = "Change Language";

  static const String termsOfService = "Terms of Service";
  static const String permissionsEnabled = "Current Permissions Enabled";
  static const String moreInfo = "Details";
  static const String deny = "DENY";

  static const String workHours = "Work Hours";
  static const String day = "Day:";
  static const List<String> weekDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  static const int sunday = 0;
  static const int monday = 1;
  static const int tuesday = 2;
  static const int wednesday = 3;
  static const int thursday = 4;
  static const int friday = 5;
  static const int saturday = 6;
  static const String titleOfRanges = "Available from:";
  static const String to = "to";
  static const String addRange = "ADD RANGE";
  static const String calendar = "Days Unavailable";
  static const List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  static const int january = 0;
  static const int february = 1;
  static const int march = 2;
  static const int april = 3;
  static const int may = 4;
  static const int june = 5;
  static const int july = 6;
  static const int august = 7;
  static const int september = 8;
  static const int october = 9;
  static const int november = 10;
  static const int december = 11;

  static String getDay(int day) {
    switch (day) {
      case DateTime.sunday:
        return weekDays.elementAt(sunday);
      case DateTime.monday:
        return weekDays.elementAt(monday);
      case DateTime.tuesday:
        return weekDays.elementAt(tuesday);
      case DateTime.wednesday:
        return weekDays.elementAt(wednesday);
      case DateTime.thursday:
        return weekDays.elementAt(thursday);
      case DateTime.friday:
        return weekDays.elementAt(friday);
      case DateTime.saturday:
        return weekDays.elementAt(saturday);
    }
    return "";
  }

  static String getMonth(int day) {
    switch (day) {
      case DateTime.january:
        return months.elementAt(january);
      case DateTime.february:
        return months.elementAt(february);
      case DateTime.march:
        return months.elementAt(march);
      case DateTime.april:
        return months.elementAt(april);
      case DateTime.may:
        return months.elementAt(may);
      case DateTime.june:
        return months.elementAt(june);
      case DateTime.july:
        return months.elementAt(july);
      case DateTime.august:
        return months.elementAt(august);
      case DateTime.september:
        return months.elementAt(september);
      case DateTime.october:
        return months.elementAt(october);
      case DateTime.november:
        return months.elementAt(november);
      case DateTime.december:
        return months.elementAt(december);
    }
    return "";
  }

  static const String colorSetter = "Theme Creator";
  static const String primaryCol = "Primary Color";
  static const String primaryVar = "Primary Variant";
  static const String secondaryCol = "Secondary Color";
  static const String secondaryVar = "Secondary Variant";
  static const String backText = "Background Text";
  static const String background = "Background";
  static const String delete = "Delete / Remove";
  static const String changeAndAdd = "Change / Add";
  static const String links = "Links";
  static const String suggestion = "Suggestion";
  static const String reset = "RESET";
  static const String saveTheme = "Save Theme";

  static const List<String> contactItems = [
    "Name",
    "Relationship",
    "Number",
    "Options",
  ];
  static const String familyContacts = "Family Contacts";
  static const String addMember = "ADD MEMBER";
  static const int name = 0;
  static const int relationship = 1;
  static const int number = 2;
  static const int options = 3;

  static const String mom = "Mom";
  static const String dad = "Dad";
  static const String parent = "Parent";
  static const String guardian = "Guardian";
}
