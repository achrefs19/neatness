class EventEntity{
  String _id="";
  String _organizer="";
  String _topic="";
  String _subject="";
  String _date="";

  String get id => _id;

  set id(String value) {
    _id = value;
  }


  EventEntity.empty();

  EventEntity(this._id, this._organizer, this._topic, this._subject, this._date);

  String get organizer => _organizer;

  set organizer(String value) {
    _organizer = value;
  }

  String get topic => _topic;

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get subject => _subject;

  set subject(String value) {
    _subject = value;
  }

  set topic(String value) {
    _topic = value;
  }
}
