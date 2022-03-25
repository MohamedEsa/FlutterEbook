class ApiRoutes {
  static const String publicDomainURL = 'publicdomain/browse';
  static const String popular = '$publicDomainURL/top.atom';
  static const String recent = '$publicDomainURL/recent.atom';
  static const String awards = '$publicDomainURL/awards.atom';
  static const String noteworthy = '$publicDomainURL/homepage_selection.atom';
  static const String shortStory = '$publicDomainURL/top.atom?cat=FBFIC029000';
  static const String sciFi = '$publicDomainURL/top.atom?cat=FBFIC028000';
  static const String actionAdventure =
      '$publicDomainURL/top.atom?cat=FBFIC002000';
  static const String mystery = '$publicDomainURL/top.atom?cat=FBFIC022000';
  static const String romance = '$publicDomainURL/top.atom?cat=FBFIC027000';
  static const String horror = '$publicDomainURL/top.atom?cat=FBFIC015000';
}
