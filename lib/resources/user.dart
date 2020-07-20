class User {

  // Appreciations
  String thoughts = "";

  List<String> getThoughts() {
    if(thoughts == null) {
      return null;
    }
    if(thoughts == "") {
      return List();
    }

    return thoughts.split("~").where((i) => i.length >= 1).toList();
  }

  bool addThought(String s) {
    String temp = "";
    if((s != null)&&(s.length >= 1)) {
      temp = s.replaceAll("~", "");
    } else {
      return false;
    }

    this.thoughts = temp + "~" + this.thoughts;
    
    return true;
  }

  bool eraseThoughts() {
    thoughts = "";
    return true;
  }

  bool disableThoughts() {
    thoughts = null;
    return true;
  }
  
  String morningMessages = "";

  List<String> getMornings() {
    if(morningMessages == null) {
      return null;
    }

    if(morningMessages == "") {
      return List();
    }
    return morningMessages.split("~").where((i) => i.length >= 1).toList();
  }

  bool addMorningMessage(String s) {
    String temp = "";
    if((s != null)&&(s.length >= 1)) {
      temp = s.replaceAll("~", "");
    } else {
      return false;
    }

    morningMessages = temp + "~" + morningMessages;
    
    return true;
  }

  bool eraseMorning() {
    morningMessages = "";
    return true;
  }

  bool disableMorning() {
    morningMessages = null;
    return true;
  }

  // Daily Value
  String dailyValues = "";

  List<int> getDailyValues() {
    if(dailyValues == null) {
      return null;
    }

    if(dailyValues == "") {
      return List();
    }

    List<String> l = dailyValues.split("~").where((i) => i.length >= 1).toList();
    return l.map((x) => int.parse(x)).toList();
  }

  bool addDailyValue(int i) {
    dailyValues = i.toString() + "~" + dailyValues;
    return true;
  }

    bool eraseDailyValues() {
    dailyValues = "";
    return true;
  }

  bool disableDailyValues() {
    dailyValues = null;
    return true;
  }

  // INSIGHTS
  String insights = "";

  List<String> getInsights() {
    if(insights == null) {
      return null;
    }

    if(insights == "") {
      return List();
    }
    return insights.split("~").where((i) => i.length >= 1).toList();
  }

  bool addInsights(String s) {
    String temp = "";
    if((s != null)&&(s.length >= 1)) {
      temp = s.replaceAll("~", "");
    } else {
      return false;
    }

    insights = temp + "~" + insights;
    print("INSIGHTS: " + insights);
    return true;
  }

    bool eraseInsights() {
    insights = "";
    return true;
  }

  bool disableInsights() {
    insights = null;
    return true;
  }

  // Personal Settings
  String version = "1.0.2";
  String name;

  User(this.name);
  User.newUser();

  bool setName(String s) {
    if(s == null) {
      name = "";
    }
    name = s;
    return true;
  }

  User.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        name = json['name'],
        thoughts = json['thoughts'],
        morningMessages = json['morningMessages'],
        dailyValues = json['dailyValues'],
        insights = json['insights'];

  Map<String, dynamic> toJson() =>
    {
      'version': version,
      'name': name,
      'thoughts': thoughts,
      'morningMessages': morningMessages,
      'dailyValues': dailyValues,
      'insights': insights
    };
}