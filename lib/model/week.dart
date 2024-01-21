import 'package:isar/isar.dart';

part 'week.g.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

@collection
class Week {
  Week({
    this.monday = const [],
    this.tuesday = const [],
    this.wednesday = const [],
    this.thursday = const [],
    this.friday = const [],
    this.saturday = const [],
    this.sunday = const [],
  });
  final Id id = Isar.autoIncrement;

  final List<Id> monday;
  final List<Id> tuesday;
  final List<Id> wednesday;
  final List<Id> thursday;
  final List<Id> friday;
  final List<Id> saturday;
  final List<Id> sunday;

  List<Id> getRecipeIds(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
        return monday;
      case Weekday.tuesday:
        return tuesday;
      case Weekday.wednesday:
        return wednesday;
      case Weekday.thursday:
        return thursday;
      case Weekday.friday:
        return friday;
      case Weekday.saturday:
        return saturday;
      case Weekday.sunday:
        return sunday;
      default:
        return [];
    }
  }
}
